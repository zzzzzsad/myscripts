import binascii
import struct
import base64
import json
import os
import subprocess
from rich.progress import Progress
import traceback
from Crypto.Cipher import AES

workdir = os.path.dirname(os.path.realpath(__file__))
tempdir = workdir + '/tmp'

file_dir    = '/run/media/diskf/music/CloudMusic/VipSongsDownload'
final_dir   = '/run/media/diskf/music/CloudMusicVip/'
recordfile  = '/run/media/diskf/music/ncmdump.log'

def filter_task(names: list):
    done_list = os.listdir(final_dir)
    done_names = set()
    for name in done_list:
        if name.endswith('.flac'):
            done_names.add(name[0:-5])
        elif name.endswith('.mp3'):
            done_names.add(name[0:-5])
    res = []

    for name in names:
        sublist = name.split('.')[0:-1]
        basename = '.'.join(sublist)
        if not basename in done_names:
            res.append(name)
    return res

def mk_relate_dirs(file_name):
    file_name = os.path.realpath(file_name)
    folder = os.path.dirname(file_name)
    if not os.path.exists(folder):
        os.makedirs(folder)

def add_cover(audio_path: str, cover_path: str, dst_path: str):
    name = os.path.split(audio_path)[1]
    name = name.replace('.ncm', '')
    dst_file = dst_path + '/' + name

    cmd = '/usr/bin/ffmpeg'
    args = (' -y -i "{}" -i "{}"  -map 0:a -map 1 -codec copy'
        ' -metadata:s:v title="Album cover" -metadata:s:v comment="Cover (front)"'
        ' -disposition:v attached_pic "{}" >> ./ffmpeg.log 2>&1').format(
            audio_path, cover_path, dst_file)
    p = subprocess.Popen(cmd + args, shell = True, stdout= subprocess.PIPE)
    p.stdout.close()

def dump(progress: Progress, file_path: str):
    core_key = binascii.a2b_hex("687A4852416D736F356B496E62617857")
    meta_key = binascii.a2b_hex("2331346C6A6B5F215C5D2630553C2728")
    unpad = lambda s : s[0:-(s[-1] if type(s[-1]) == int else ord(s[-1]))]
    f = open(file_path,'rb')
    header = f.read(8)
    assert binascii.b2a_hex(header) == b'4354454e4644414d'

    old_position = f.tell()
    f.seek(0, os.SEEK_END)
    file_size = f.tell()
    f.seek(old_position, os.SEEK_SET)

    f.seek(2, 1)
    key_length = f.read(4)
    key_length = struct.unpack('<I', bytes(key_length))[0]
    key_data = f.read(key_length)
    key_data_array = bytearray(key_data)

    for i in range (0, len(key_data_array)):
        key_data_array[i] ^= 0x64
    key_data = bytes(key_data_array)
    cryptor = AES.new(core_key, AES.MODE_ECB)
    key_data = unpad(cryptor.decrypt(key_data))[17:]
    key_length = len(key_data)
    key_data = bytearray(key_data)
    key_box = bytearray(range(256))
    c = 0
    last_byte = 0
    key_offset = 0
    for i in range(256):
        swap = key_box[i]
        c = (swap + last_byte + key_data[key_offset]) & 0xff
        key_offset += 1
        if key_offset >= key_length: key_offset = 0
        key_box[i] = key_box[c]
        key_box[c] = swap
        last_byte = c

    meta_length = f.read(4)
    meta_length = struct.unpack('<I', bytes(meta_length))[0]
    meta_data = f.read(meta_length)
    meta_data_array = bytearray(meta_data)
    for i in range(0,len(meta_data_array)):
        meta_data_array[i] ^= 0x63
    meta_data = bytes(meta_data_array)
    meta_data = base64.b64decode(meta_data[22:])
    cryptor = AES.new(meta_key, AES.MODE_ECB)
    meta_data = unpad(cryptor.decrypt(meta_data)).decode('utf-8')[6:]
    meta_data = json.loads(meta_data)
    crc32 = f.read(4)
    crc32 = struct.unpack('<I', bytes(crc32))[0]
    f.seek(5, 1)
    image_size = f.read(4)
    image_size = struct.unpack('<I', bytes(image_size))[0]
    image_data = f.read(image_size)

    file_name = os.path.split(file_path)[1] + '.' + meta_data['format']
    dst_path = tempdir + '/' + file_name
    image_path = dst_path + '.jpg'

    mk_relate_dirs(dst_path)
    m = open(dst_path, 'wb')
    chunk = bytearray()
    last_size = file_size - f.tell()
    tt = progress.add_task(meta_data['musicName'], total= last_size)
    while True:
        chunk = bytearray(f.read(0x8000))
        chunk_length = len(chunk)
        if not chunk:
            break
        for i in range(1, chunk_length+1):
            j = i & 0xff;
            chunk[i-1] ^= key_box[(key_box[j] + key_box[(key_box[j] + j) & 0xff]) & 0xff]
        m.write(chunk)
        progress.update(tt, advance = chunk_length)
    m.close()
    f.close()

    mk_relate_dirs(image_path)
    with open(image_path, 'wb') as imgf:
        imgf.write(image_data)

    add_cover(dst_path, image_path, final_dir)

if __name__ == '__main__':
    names = os.listdir(file_dir)
    print('all files', len(names))

    names = filter_task(names)
    print('filter all files', len(names))

    with Progress() as progress:
        t1 = progress.add_task("all files...", total = len(names))
        for i in range(len(names)):
            file_name = names[i]
            file_path = file_dir + '/' + file_name
            try:
                dump(progress, file_path)
            except Exception:
                print('process {} excepted'.format(file_name))
                traceback.print_exc()
            progress.update(t1, advance= 1, description = 'all files {}/{}'.format(i+1, len(names)))
