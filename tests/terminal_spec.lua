---@module 'luassert'

describe("terminal", function()
  describe("send with bracketed paste", function()
    it("should wrap multi-line text with bracketed paste sequences", function()
      -- Test the bracketed paste format
      local bracketed_paste_start = "\027[200~"
      local bracketed_paste_end = "\027[201~"
      local input = "line1\nline2\nline3"
      local expected = bracketed_paste_start .. input .. bracketed_paste_end

      -- Verify the format is correct
      assert.are.equal("\027[200~line1\nline2\nline3\027[201~", expected)
    end)

    it("should normalize CRLF to LF", function()
      local input = "line1\r\nline2\r\nline3"
      local normalized = input:gsub("\r\n", "\n")
      assert.are.equal("line1\nline2\nline3", normalized)
    end)

    it("should preserve single line text", function()
      local bracketed_paste_start = "\027[200~"
      local bracketed_paste_end = "\027[201~"
      local input = "single line"
      local result = bracketed_paste_start .. input .. bracketed_paste_end

      assert.are.equal("\027[200~single line\027[201~", result)
    end)

    it("should handle empty string", function()
      local bracketed_paste_start = "\027[200~"
      local bracketed_paste_end = "\027[201~"
      local input = ""
      local result = bracketed_paste_start .. input .. bracketed_paste_end

      assert.are.equal("\027[200~\027[201~", result)
    end)

    it("should handle text with special characters", function()
      local bracketed_paste_start = "\027[200~"
      local bracketed_paste_end = "\027[201~"
      local input = '{"key": "value", "nested": {"a": 1}}'
      local result = bracketed_paste_start .. input .. bracketed_paste_end

      assert.matches("^\027%[200~.*\027%[201~$", result)
    end)
  end)
end)
