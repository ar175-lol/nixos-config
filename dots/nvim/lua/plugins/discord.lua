return {
  "vyfor/cord.nvim",
  build = './gradlew linkReleaseSharedNative --no-daemon --no-build-cache',
  event = "VeryLazy",
  opts = {}, -- Leave empty for default settings, or add custom configuration here
}
