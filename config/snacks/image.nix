{
  plugins.snacks = {
    enable = true;

    settings.image = {
      enabled = true;
    };

    # luaConfig.post = ''
    #   local doc = require("snacks.image.doc")
    #
    #   -- Avoid wrapping the transform multiple times when reloading config.
    #   if not doc._markdown_typst_patched then
    #     doc._markdown_typst_patched = true
    #
    #     local render_latex = doc.transforms.latex
    #     local render_typst = doc.transforms.typst
    #
    #     doc.transforms.latex = function(img, ctx)
    #       -- Preserve the original renderer for actual LaTeX documents.
    #       if vim.bo[ctx.buf].filetype ~= "markdown" then
    #         return render_latex(img, ctx)
    #       end
    #
    #       if not (img.content and img.ext == "math.tex") then
    #         return
    #       end
    #
    #       local content = vim.trim(img.content)
    #       local node_type =
    #         ctx.content and ctx.content.node:type() or ""
    #
    #       local is_block =
    #         node_type == "displayed_equation"
    #         or content:match("^%$%$") ~= nil
    #
    #       if is_block then
    #         -- Markdown:
    #         --
    #         -- $$
    #         -- sum_(i=1)^n i
    #         -- $$
    #         --
    #         -- Typst block math:
    #         --
    #         -- $
    #         -- sum_(i=1)^n i
    #         -- $
    #         content = content:gsub("^%$%$%s*", "", 1)
    #         content = content:gsub("%s*%$%$$", "", 1)
    #
    #         img.content = "$\n" .. vim.trim(content) .. "\n$"
    #       else
    #         -- Markdown $...$ -> Typst inline $...$
    #         content = content:gsub("^%$%s*", "", 1)
    #         content = content:gsub("%s*%$$", "", 1)
    #
    #         img.content = "$" .. vim.trim(content) .. "$"
    #       end
    #
    #       -- Make Snacks invoke the Typst conversion pipeline.
    #       img.ext = "math.typ"
    #       return render_typst(img, ctx)
    #     end
    #   end
    # '';
  };

}
