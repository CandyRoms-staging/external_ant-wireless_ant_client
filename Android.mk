#
# ANT Stack
#
# Copyright 2011 Dynastream Innovations
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

ifneq ($(BOARD_ANT_WIRELESS_DEVICE),)
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

BT_ON_SRC_FILES := \
     src/com/dsi/ant/server/StateChangedReceiver.java

#
# ANT java system service
#

LOCAL_SRC_FILES := \
    $(call all-java-files-under, src) \
    src/com/dsi/ant/server/IAntHal.aidl \
    src/com/dsi/ant/server/IAntHalCallback.aidl

#
# If target board is not one that requires Bluetooth to be enabled for ANT to enable, 
# filter out files that are only needed for Bluetooth to enable when ANT is enabled.
#

ifeq ($(filter msm8610 msm8226 msm8974, $(TARGET_BOARD_PLATFORM)),)
LOCAL_SRC_FILES := \
     $(filter-out  $(BT_ON_SRC_FILES), $(LOCAL_SRC_FILES))
endif

LOCAL_REQUIRED_MODULES := libantradio
LOCAL_PROGUARD_FLAG_FILES := proguard.flags
LOCAL_CERTIFICATE := platform
LOCAL_MODULE_TAGS := optional
LOCAL_PACKAGE_NAME := AntHalService

include $(BUILD_PACKAGE)

endif # BOARD_ANT_WIRELESS_DEVICE defined