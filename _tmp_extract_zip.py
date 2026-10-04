import os
import shutil
import zipfile

SRC = "/tmp/school360techx-web-ui-refresh.zip"
DST = "/tmp/school360techx-web-ui-refresh"

shutil.rmtree(DST, ignore_errors=True)
os.makedirs(DST, exist_ok=True)

with zipfile.ZipFile(SRC, "r") as zf:
    for member in zf.infolist():
        safe_name = member.filename.replace("\\", "/")
        if safe_name.endswith("/"):
            os.makedirs(os.path.join(DST, safe_name), exist_ok=True)
            continue
        out_path = os.path.join(DST, safe_name)
        os.makedirs(os.path.dirname(out_path), exist_ok=True)
        with zf.open(member, "r") as src, open(out_path, "wb") as dst_file:
            shutil.copyfileobj(src, dst_file)

print("ok")
