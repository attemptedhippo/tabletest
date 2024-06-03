local suit = require("suit")

local input = { text = "" }

-- Define the N-ary tree node
local Node = {}
Node.__index = Node

local MyColors = {}
MyColors.Red = { 1, 0, 0 }
MyColors.Blue = { 0, 0, 1 }
MyColors.Yellow = { 1, 1, 0 }
MyColors.Green = { 0, 1, 0 }

function Node.new(data1, data2, data3, data4)
	local self = setmetatable({}, Node)
	self.data1 = data1
	self.data2 = data2
	self.data3 = data3
	self.data4 = data4
	self.children = {} -- Store child nodes
	return self
end

-- Add a child to the node
function Node:addChild(child)
	table.insert(self.children, child)
end

-- Remove a child from the node
function Node:removeChild(child)
	for i, existingChild in ipairs(self.children) do
		if existingChild == child then
			table.remove(self.children, i)
			return true -- Child removed successfully
		end
	end
	return false -- Child not found
end

-- Example usage
-- root = Node.new((id)"Root", (bool)traveled, (bool)currentlyHere, (enum?)"location"(inn/forrest/fight), (image)background, (string(or table of strings?))dialogue)
local root = Node.new("Root", "Red", "Sample_fantasy.png", "Hello world")
local child1 = Node.new("Child1", "Blue", "Sample_fantasy.png", "Child1")
local child2 = Node.new("Child2", "Blue", "Sample_urban.png", "Child2")
local child3 = Node.new("Child3", "Yellow", "Sample_interior.png", "Child3")

root:addChild(child1)
root:addChild(child2)
child2:addChild(child3)

local CurrentNode = root

-- Print the tree (depth-first traversal)
local function printTree(node, depth)
	depth = depth or 0
	print(("  "):rep(depth) .. node.data1 .. ":" .. node.data2)
	for _, child in ipairs(node.children) do
		printTree(child, depth + 1)
	end
end

local function drawDial(node)
	local screenWidth = love.graphics.getWidth()
	local screenHeight = love.graphics.getHeight()
	local bottomOfScreenPadding = 20
	local panelHeight = 150
	local panelPadding = 5
	local panelMargin = 10
	local offsetSides = screenWidth / 5
	local offsetTop = screenHeight - panelHeight - bottomOfScreenPadding -- - panelMargin * 2
	local computedWidth = screenWidth - offsetSides * 2 - panelMargin * 2

	love.graphics.setColor(love.math.colorFromBytes(44, 47, 51))
	love.graphics.rectangle(
		"fill",
		offsetSides - panelMargin,
		offsetTop - panelMargin,
		computedWidth + panelMargin * 2,
		panelHeight + panelMargin + panelPadding
	)

	suit.layout:reset(offsetSides, offsetTop, panelPadding)
	love.graphics.setColor(MyColors[CurrentNode.data2])
	love.graphics.print(node.data4, screenWidth / 2, 200)
	local x, y, w, h = suit.layout:row(computedWidth, panelHeight * 0.75)
	love.graphics.printf(node.data4, x, y, w, "left")
	love.graphics.rectangle("line", x, y, w, h)

	--300, 100) --0.75 * panelHeight)
	-- suit.Label(node.data4, { align = "left" }, suit.layout:row(offsetSides * 3 + 40, panelHeight * 0.75))
	suit.layout:push(suit.layout:row(0, panelHeight * 0.25))
	-- love.graphics.rectangle("line", suit.layout:size())
	if suit.Button("Bueton", suit.layout:col((computedWidth - 2 * panelPadding) / 3, 30)).hit then
		CurrentNode = CurrentNode.children[1]
	end
	suit.layout:col()
	if suit.Button("Bueton2", suit.layout:col()).hit then
		CurrentNode = CurrentNode.children[2]
	end
	suit.layout:pop()
end

local function drawTree(node)
	local img = love.graphics.newImage(node.data3)
	-- love.graphics.draw(img, 0, 0)
	drawDial(node)
end

function love.load()
	-- print("\n")
	-- printTree(root)
end

function love.update(dt) end

function love.draw()
	drawTree(CurrentNode)
	suit.draw()
end

function love.keypressed(key)
	suit.keypressed(key)
end
