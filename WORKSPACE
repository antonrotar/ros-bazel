# -*- python -*-
workspace(name = "ros_bazel")

load("@ros_bazel//bazel:repository_rules.bzl", "import_ros_workspace", "code_generation_repositories")

import_ros_workspace(
    name = "ros_ws",
    path = "/opt/ros/melodic",
)

load("@ros_ws//:workspace.bzl", "ros_repositories")

ros_repositories()

code_generation_repositories()
