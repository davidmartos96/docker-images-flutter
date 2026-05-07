FROM cimg/android:2026.03.1

USER root

ARG flutter_version

ENV FLUTTER_ROOT=/opt/flutter \
    FLUTTER_VERSION=$flutter_version \
    PATH=$PATH:/opt/flutter/bin:/opt/flutter/bin/cache/dart-sdk/bin

RUN mkdir -p ${FLUTTER_ROOT}

# Install Flutter (rarely changes → good cache layer)
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} \
    https://github.com/flutter/flutter.git ${FLUTTER_ROOT}

# Accept licenses (stable layer)
RUN set +o pipefail && yes | sdkmanager --licenses > /dev/null && set -o pipefail

# Precache only what we need (important for speed)
RUN flutter precache --android

# Warm up Flutter once (creates cache dirs)
RUN flutter doctor

# Remove git history to shrink layer
RUN rm -rf ${FLUTTER_ROOT}/.git

# ENV FLUTTER_HOME=/sdks/flutter \
#     FLUTTER_VERSION=$flutter_version
# ENV FLUTTER_ROOT=$FLUTTER_HOME

# ENV PATH=${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

# RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

# RUN yes | flutter doctor --android-licenses || true

# RUN flutter doctor

# RUN chown -R root:root ${FLUTTER_HOME}

# RUN flutter precache --android
