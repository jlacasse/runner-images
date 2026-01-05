| Announcements |
|-|
| [[all OSs] Android NDK r27, r28 and r29 will be removed from images on January 27, 2025](https://github.com/actions/runner-images/issues/11396) |
| [[Ubuntu, Windows] .NET 6 and .NET 7 will be removed from images on January 13, 2025](https://github.com/actions/runner-images/issues/11335) |
***
# Windows Server 2025 with Visual Studio 2026
- OS Version: 10.0.26100 Build 26100
- Image Version: dev

## Windows features
This image contains the same Windows features as the standard Windows Server 2025 image, with the primary difference being Visual Studio 2026 instead of Visual Studio 2022.

## Visual Studio Enterprise 2026
This image includes Visual Studio Enterprise 2026 (version 18.x).

For a complete list of installed components and workloads, the image will be generated during the build process.

## Notes
- This is a variant of the Windows Server 2025 image with Visual Studio 2026.
- All other tools and software remain consistent with the base Windows 2025 image.
- The software report will be generated during the image build process.

For more details about the base Windows Server 2025 image, see [Windows2025-Readme.md](Windows2025-Readme.md).
