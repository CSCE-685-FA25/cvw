import os
import shutil

WALLY_HOME = os.getenv("WALLY", "../../")

BUILDROOT_SRC = "linux/buildroot-config-src/wally"
TESTVECTOR_SRC = "linux/testvector-generation"

shutil.copytree(os.path.join(WALLY_HOME, BUILDROOT_SRC), "./buildroot-config-src")
shutil.copytree(os.path.join(WALLY_HOME, TESTVECTOR_SRC), "./testvector-generation")
