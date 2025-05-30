/*
 * Copyright (C) 2020 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#pragma once

#include <memory>

#include <aidl/android/hardware/power/BnPower.h>

#include <OperatorFactory.h>

namespace aidl {
namespace android {
namespace hardware {
namespace power {
namespace impl {
namespace exynos {

class Power : public BnPower {
public:
    Power();
    virtual ~Power() override;

    ndk::ScopedAStatus setMode(Mode type, bool enabled) override;
    ndk::ScopedAStatus isModeSupported(Mode type, bool* _aidl_return) override;
    ndk::ScopedAStatus setBoost(Boost type, int32_t durationMs) override;
    ndk::ScopedAStatus isBoostSupported(Boost type, bool* _aidl_return) override;
    ndk::ScopedAStatus createHintSession(int32_t tgid, int32_t uid,
                                         const std::vector<int32_t>& threadIds,
                                         int64_t durationNanos,
                                         std::shared_ptr<IPowerHintSession>* _aidl_return) override;
    ndk::ScopedAStatus getHintSessionPreferredRate(int64_t* outNanoseconds) override;

    void checkPropertyAvailable(const std::string property, bool &flag);
    bool checkEpicOperator();

    bool mEnableTouchBooster;
    bool mEnableAppLaunchBooster;
    bool mEnableAppLaunchReleaseHint;

    void setCurMode(int32_t type);
    int32_t getCurMode();

    int32_t curMode;

    std::shared_ptr<epic::IEpicOperator> mTouchBooster;
    std::shared_ptr<epic::IEpicOperator> mTouchBoosterDuration;
    std::shared_ptr<epic::IEpicOperator> mAppLaunchBooster;

    constexpr static const int32_t MODE_DEF = -1;

private:
    std::vector<std::shared_ptr<IPowerHintSession>> mPowerHintSessions;
};

}  // namespace exynos
}  // namespace impl
}  // namespace power
}  // namespace hardware
}  // namespace android
}  // namespace aidl
