CE = {}
CE.Esc = false
CE.Esc2 = false
CE.MenuOpen = false

surface.CreateFont("CustEsc", {
	font = "DebugFixed",
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
})

surface.CreateFont("CustEsc2", {
	font = "DebugFixed",
	size = 50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
})

function CE.Menu()
	local Main = vgui.Create("DFrame")
	Main:SetSize(ScrW(), ScrH())
	Main:SetTitle("")
	Main:Center()
	Main:MakePopup()
	Main:SetDraggable(false)
	Main:ShowCloseButton(false)
	
	function Main.ResumeGame()
		Main:Remove()
		CE.MenuOpen = false
	end
	
	function Main.Paint(self)
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 215))
		draw.SimpleText(GetHostName(), "CustEsc2", self:GetWide() / 2, 20, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	local Resume = vgui.Create("DButton", Main)
	Resume:SetSize(87, 25)
	Resume:SetPos(40, 70)
	Resume:SetText("")
		
	function Resume.Paint(self)
		/*
		draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(75, 75, 75))
		surface.SetDrawColor(70, 70, 70)
		surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
		*/
		draw.SimpleText("Resume", "CustEsc", self:GetWide() / 2 - 45, self:GetTall() / 2 - 17, Color(0, 255, 0))
	end
		
	function Resume.DoClick()
		Main.ResumeGame()
	end
	
	local Disconnect = vgui.Create("DButton", Main)
	Disconnect:SetSize(125, 25)
	Disconnect:SetPos(40, 100)
	Disconnect:SetText("")
		
	function Disconnect.Paint(self)
		/*
		draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(75, 75, 75))
		surface.SetDrawColor(70, 70, 70)
		surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
		*/
		draw.SimpleText("Disconnect", "CustEsc", self:GetWide() / 2 - 64, self:GetTall() / 2 - 17, Color(255, 255, 0))
	end
		
	function Disconnect.DoClick()
		RunConsoleCommand("gamemenucommand", "Disconnect")
	end
	
	local Quit = vgui.Create("DButton", Main)
	Quit:SetSize(50, 25)
	Quit:SetPos(40, 130)
	Quit:SetText("")
		
	function Quit.Paint(self)
		/*
		draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), Color(75, 75, 75))
		surface.SetDrawColor(70, 70, 70)
		surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
		*/
		draw.SimpleText("Quit", "CustEsc", self:GetWide() / 2 - 25, self:GetTall() / 2 - 17, Color(255, 15, 25))
	end
		
	function Quit.DoClick()
		RunConsoleCommand("gamemenucommand", "Quit")
	end
	
	function Main.Think()
		if input.IsKeyDown(KEY_ESCAPE) and !CE.Esc2 then
			Main.ResumeGame()
		end
	end
end

function CE.Check()
	if input.IsKeyDown(KEY_ESCAPE) and !CE.MenuOpen and !CE.Esc then
		CE.MenuOpen = true
		CE.Esc = true
		CE.Menu()
	elseif !input.IsKeyDown(KEY_ESCAPE) and !CE.MenuOpen then
		CE.Esc = false
	end
	
	if input.IsKeyDown(KEY_ESCAPE) and CE.Esc and CE.MenuOpen then
		CE.Esc2 = true
	else
		CE.Esc2 = false
	end
end

function CE.HideGameUI()
	if input.IsKeyDown(KEY_ESCAPE) then
		gui.HideGameUI()
	end
end

hook.Add("Think", "CE.Check", CE.Check)
hook.Add("CreateMove", "CE.HideGameUI", CE.HideGameUI)
