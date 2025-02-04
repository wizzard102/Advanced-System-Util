cd C:\Windows\System32\WinBioPlugIns\FaceDriver
pnputil.exe /delete-driver .\HelloFace.inf
pnputil.exe /add-driver .\HelloFace.inf /install