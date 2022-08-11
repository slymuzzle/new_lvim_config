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

local M = {}

M.config ={
    dashboard = {
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
            footer = {
                type = "text",
                val = getGreeting(os.getenv("USER")),
                opts = {
                    position = "center",
                    hl = "Label",
                },
            },
        }
    }
}

return M

