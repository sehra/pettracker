--[[
Copyright 2012-2023 João Cardoso
PetTracker is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of PetTracker.
--]]

local MODULE = ...
local ADDON, Addon = MODULE:match('[^_]+'), _G[MODULE:match('[^_]+')]
local Tutorials = PetTracker:NewModule('Tutorials', 'CustomTutorials-2.1')
local L = LibStub('AceLocale-3.0'):GetLocale('PetTracker')


--[[ Startup ]]--

function Tutorials:OnEnable()
	self:Load()
	self:Start()

	self:HookShown(WorldMapFrame, 'Load')
	self:RegisterEvent('ADDON_LOADED', 'Load')
	self:RegisterSignal('OPTIONS_RESET', 'Start')
end

function Tutorials:Load()
	local mapTrackingButton = Addon.MapSearch.Frames[WorldMapFrame]

	self:RegisterTutorials {
		title = ADDON,
		savedvariable = Addon.sets, key = 'tutorial',

		{
			text = L.Tutorial[1],
			image = 'Interface/Addons/PetTracker/Art/Pets',
			point = 'CENTER'
		},
		{
			text = L.Tutorial[2],
			point = 'TOPRIGHT', relPoint = 'TOPLEFT',
			image = 'Interface/Addons/PetTracker/Art/Tracker',
			shineRight = 10, shineLeft = -35,
			shineTop = 6, shineBottom = 0,
			anchor = ObjectiveTrackerFrame,
			shine = ObjectiveTrackerFrame,
			x = -40
		},
		{
			text = L.Tutorial[3],
			point = 'TOPRIGHT', relPoint = 'TOPLEFT',
			anchor = Addon.Objectives and Addon.Objectives.Header or Minimap,
			shine = Addon.Objectives and Addon.Objectives.Header,
			shineRight = 10, shineLeft = -20,
			shineTop = 10, shineBottom = -7,
			x = -30
		},
		{
			text = L.Tutorial[4],
			point = 'TOPRIGHT', relPoint = 'TOPLEFT',
			anchor = MinimapCluster.ZoneTextButton,
			shine = MinimapCluster.ZoneTextButton,
			shineRight = -5, shineLeft = -12,
			shineTop = 9, shineBottom = -9,
			y = -15
		},
		{
			text = L.Tutorial[5],
			point = 'TOPRIGHT', relPoint = 'BOTTOMLEFT',
			anchor = mapTrackingButton, shine = mapTrackingButton,
			shineTop = 5, shineBottom = -5,
			shineRight = 7, shineLeft = -5,
			x = -5, y = -5
		},
		{
			text = L.Tutorial[6],
			point = 'TOPRIGHT', relPoint = 'BOTTOMLEFT',
			shineTop = 6, shineBottom = -6,
			shineRight = 6, shineLeft = -12,
			shine = Addon.MapSearch.Editbox,
			anchor = mapTrackingButton,
			x = -5, y = -5
		},
		{
			text = L.Tutorial[7],
			point = 'BOTTOM', relPoint = 'TOP',
			anchor = CollectionsMicroButton,
			shine = CollectionsMicroButton,
			shineTop = 7, shineBottom = -7,
			shineRight = 7, shineLeft = -7,
			y = 10
		},
		{
			text = L.Tutorial[8],
			point = 'BOTTOMLEFT', relPoint = 'TOPLEFT',
			anchor = Addon.TrackToggle, shine = Addon.TrackToggle,
			shineLeft = -4, shineRight = 4,
			shineBottom = -4, shineTop = 3,
			x = 20
		},
		{
			text = L.Tutorial[9],
			point = 'BOTTOMLEFT', relPoint = 'TOPRIGHT',
			anchor = Addon.RivalsJournal and Addon.RivalsJournal.PanelTab,
			shine = Addon.RivalsJournal and Addon.RivalsJournal.PanelTab,
			shineLeft = -5, shineRight = 5,
			shineBottom = -2, shineTop = 5,
			x = 20
		},
		{
			text = L.Tutorial[10],
			point = 'TOPLEFT', relPoint = 'TOPRIGHT',
			anchor = Addon.RivalsJournal,
			x = 20
		},
		{
			text = L.Tutorial[11],
			point = 'TOPLEFT', relPoint = 'BOTTOMRIGHT',
			anchor = Addon.RivalsJournal and Addon.RivalsJournal.SearchBox,
			shine = Addon.RivalsJournal and Addon.RivalsJournal.SearchBox,
			shineTop = 6, shineBottom = -6,
			shineRight = 6, shineLeft = -12,
			x = 15
		},
		{
			text = L.Tutorial[12],
			point = 'TOPLEFT', relPoint = 'TOPRIGHT',
			anchor = CollectionsJournal,
			shine = Addon.RivalsJournal and Addon.RivalsJournal.Tab3,
			shineLeft = -3, shineRight = 5,
			shineBottom = -5, shineTop = 3,
			x = 20
		},
	}

	self:TriggerOn(mapTrackingButton, 5)
	self:TriggerOn(Addon.MapSearch.Editbox, 7)
	self:TriggerOn(Addon.TrackToggle, 9)
	self:TriggerOn(Addon.RivalsJournal, 12)
end

function Tutorials:Start()
	self:TriggerTutorial(4)
end


--[[ API ]]--

function Tutorials:TriggerOn(frame, step)
	self:HookShown(frame, 'TriggerTutorial', step)
end

function Tutorials:HookShown(frame, call, arg)
	if frame and not self[frame] then
		if frame:IsVisible() then
			self[call](self, arg)
		else
			frame:HookScript('OnShow', function()
				if self[frame] == 0 then
					self[call](self, arg)
					self[frame] = 1
				end					
			end)
		end

		self[frame] = 0
	end
end
