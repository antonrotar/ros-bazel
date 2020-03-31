load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _import_ros_workspace_impl(repo_ctx):
    repo_ctx.file("BUILD", "")

    # Generate top-level workspace.bzl file and build files for all ROS packages
    # in the workspace.
    res = repo_ctx.execute([
        repo_ctx.path(repo_ctx.attr._gen_ros_workspace),
        "--ws-name",
        "ros_ws",
        "--ros-path",
        repo_ctx.attr.path,
        "--out-dir",
        repo_ctx.path(""),
    ])

    if res.return_code:
        fail("failed to generate ROS workspace at {}: {} ({})".format(
            repo_ctx.attr.path,
            res.stdout,
            res.stderr,
        ))

import_ros_workspace = repository_rule(
    attrs = {
        "path": attr.string(mandatory = True),
        "_gen_ros_workspace": attr.label(
            executable = True,
            default = Label("@ros_bazel//bazel:gen_ros_workspace_bzl.py"),
            cfg = "host",
        ),
    },
    implementation = _import_ros_workspace_impl,
)

def code_generation_repositories():
    http_archive(
        name = "genmsg_repo",
        build_file = "@ros_bazel//bazel:genmsg.BUILD",
        sha256 = "d7627a2df169e4e8208347d9215e47c723a015b67ef3ed8cda8b61b6cfbf94d2",
        strip_prefix = "genmsg-0.5.8",
        urls = ["https://github.com/ros/genmsg/archive/0.5.8.tar.gz"],
    )

    http_archive(
        name = "genpy_repo",
        build_file = "@ros_bazel//bazel:genpy.BUILD",
        sha256 = "35e5cd2032f52a1f77190df5c31c02134dc460bfeda3f28b5a860a95309342b9",
        strip_prefix = "genpy-0.6.5",
        urls = ["https://github.com/ros/genpy/archive/0.6.5.tar.gz"],
    )

    http_archive(
        name = "gencpp_repo",
        build_file = "@ros_bazel//bazel:gencpp.BUILD",
        sha256 = "1340928931d873e2d43801b663a4a8d87402b88173adb01e21e58037d490fda5",
        strip_prefix = "gencpp-0.5.5",
        urls = ["https://github.com/ros/gencpp/archive/0.5.5.tar.gz"],
    )
