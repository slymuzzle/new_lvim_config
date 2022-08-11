local function getGreeting(name)
	local tableTime = os.date("*t")
	local hour = tableTime.hour
	local greetingsTable = {
		[1] = "  Sleep well",
		[2] = "  Good morning",
		[3] = "  Good afternoon",
		[4] = "  Good evening",
		[5] = "望 Good night",
	}
	local greetingIndex = nil
	if hour == 23 or hour < 7 then
		greetingIndex = 1
	elseif hour < 12 then
		greetingIndex = 2
	elseif hour >= 12 and hour < 18 then
		greetingIndex = 3
	elseif hour >= 18 and hour < 21 then
		greetingIndex = 4
	elseif hour >= 21 then
		greetingIndex = 5
	end
	return greetingsTable[greetingIndex] .. ", " .. name
end

local function getPlugins()
    local plugins = nil
    if vim.fn.has("linux") == 1 or vim.fn.has("mac") == 1 then
        local handle = io.popen('fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | grep pack | wc -l | tr -d "\n" ')
        if handle == nil then
            return nil
        end
        plugins = handle:read("*a")
        handle:close()

        plugins = plugins:gsub("^%s*(.-)%s*$", "%1")
    else
        plugins = "N/A"
    end
end

local M = {}

M.dashboard = {
    section = {
        header = {
            type = "text",
            val = {
                "  .-')                                (`-.           _   .-')    ",
                " ( OO ).                            _(OO  )_        ( '.( OO )_  ",
                "(_)---\\_) ,--.       ,--.   ,--.,--(_/   ,. \\ ,-.-') ,--.   ,--.)",
                "/    _ |  |  |.-')    \\  `.'  / \\   \\   /(__/ |  |OO)|   `.'   | ",
                "\\  :` `.  |  | OO ) .-')     /   \\   \\ /   /  |  |  \\|         | ",
                " '..`''.) |  |`-' |(OO  \\   /     \\   '   /,  |  |(_/|  |'.'|  | ",
                ".-._)   \\(|  '---.' |   /  /\\_     \\     /__),|  |_.'|  |   |  | ",
                "\\       / |      |  `-./  /.__)     \\   /   (_|  |   |  |   |  | ",
                " `-----'  `------'    `--'           `-'      `--'   `--'   `--' ",
            },
            opts = {
                position = "center",
                hl = "Label",
            },
        },
        buttons = {
            entries = {
                { "SPC f", "  Find File", "<CMD>Telescope find_files<CR>" },
                { "SPC n", "  New File", "<CMD>ene!<CR>" },
                { "SPC P", "  Recent Projects ", "<CMD>Telescope projects<CR>" },
                { "SPC s r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
                { "SPC s t", "  Find Word", "<CMD>Telescope live_grep<CR>" },
                {
                    "SPC L c",
                    "  Configuration",
                    "<CMD>edit " .. require("lvim.config"):get_user_config_path() .. " <CR>",
                },
            },
        },
        greetHeading = {
            type = "text",
            val = getGreeting("Egor"),
            opts = {
                position = "center",
                hl = "String",
            },
        },
        pluginCount = {
            type = "text",
            val = "  " .. getPlugins() .. " plugins in total",
            opts = {
                position = "center",
                hl = "String",
            },
        }
    }
}

return M

local header = {
	type = "text",
	val = {
		[[             o\             ]],
		[[   _________/__\__________  ]],
		[[  |                  - (  | ]],
		[[ ,'-.                 . `-| ]],
		[[(____".       ,-.    '   || ]],
		[[  |          /\,-\   ,-.  | ]],
		[[  |      ,-./     \ /'.-\ | ]],
		[[  |     /-.,\      /     \| ]],
		[[  |    /     \    ,-.     \ ]],
		[[  |___/_______\__/___\_____\]],
	},
	opts = {
		position = "center",
		hl = "Comment",
	},
}

local function getGreeting(name)
	local tableTime = os.date("*t")
	local hour = tableTime.hour
	local greetingsTable = {
		[1] = "  Sleep well",
		[2] = "  Good morning",
		[3] = "  Good afternoon",
		[4] = "  Good evening",
		[5] = "望 Good night",
	}
	local greetingIndex = ""
	if hour == 23 or hour < 7 then
		greetingIndex = 1
	elseif hour < 12 then
		greetingIndex = 2
	elseif hour >= 12 and hour < 18 then
		greetingIndex = 3
	elseif hour >= 18 and hour < 21 then
		greetingIndex = 4
	elseif hour >= 21 then
		greetingIndex = 5
	end
	return greetingsTable[greetingIndex] .. ", " .. name
end

local userName = "Emuel"
local greeting = getGreeting(userName)

local greetHeading = {
	type = "text",
	val = greeting,
	opts = {
		position = "center",
		hl = "String",
	},
}

local plugins = ""
if vim.fn.has("linux") == 1 or vim.fn.has("mac") == 1 then
	local handle = io.popen('fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | grep pack | wc -l | tr -d "\n" ')
	if handle == nil then
		return nil
	end
	plugins = handle:read("*a")
	handle:close()

	plugins = plugins:gsub("^%s*(.-)%s*$", "%1")
else
	plugins = "N/A"
end

local pluginCount = {
	type = "text",
	val = "  " .. plugins .. " plugins in total",
	opts = {
		position = "center",
		hl = "String",
	},
}

local quote = "First, solve the problem. Then, write the code."

local quoteAuthor = "John Johnson"
local fullQuote = quote .. "\n \n                  - " .. quoteAuthor

local fortune = {
	type = "text",
	val = fullQuote,
	opts = {
		position = "center",
		hl = "Comment",
	},
}

local function button(sc, txt, keybind)
	local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

	local opts = {
		position = "center",
		text = txt,
		shortcut = sc,
		cursor = 6,
		width = 19,
		align_shortcut = "right",
		hl_shortcut = "Number",
		hl = "Function",
	}
	if keybind then
		opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
	end

	return {
		type = "button",
		val = txt,
		on_press = function()
			local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
		opts = opts,
	}
end

local buttons = {
	type = "group",
	val = {
		button("s", "   Restore", ":SessionManager load_last_session<CR>"),
		button("r", "   Recents", ":Telescope oldfiles<CR>"),
		button("p", "   Projects", ":Telescope projects<CR>"),
		button("f", "   Search", ":Telescope find_files<CR>"),
		button("e", "   Create", ":ene <BAR> startinsert<CR>"),
		button("u", "   Update", ":PackerSync<CR>"),
		button("c", "   Config", ":e ~/.config/nvim/<CR>"),
		button("q", "   Quit", ":qa!<CR>"),
	},
	opts = {
		position = "center",
		spacing = 1,
	},
}

local section = {
	header = header,
	buttons = buttons,
	greetHeading = greetHeading,
	pluginCount = pluginCount,
	footer = fortune,
}

local opts = {
	layout = {
		{ type = "padding", val = 3 },
		section.header,
		{ type = "padding", val = 3 },
		section.greetHeading,
		section.pluginCount,
		{ type = "padding", val = 2 },
		section.buttons,
		{ type = "padding", val = 2 },
		section.footer,
	},
	opts = {
		margin = 44,
	},
}
alpha.setup(opts)
