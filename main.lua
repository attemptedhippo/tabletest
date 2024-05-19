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
	local panelHeight = 150
	local offsetSides = love.graphics.getWidth() / 5 --) - 20
	-- local offsetTop = love.graphics.getHeight() / 5
	local offsetTop = love.graphics.getHeight() - panelHeight - 20
	love.graphics.setColor(love.math.colorFromBytes(44, 47, 51))
	love.graphics.rectangle("fill", offsetSides - 20, offsetTop, offsetSides * 3 + 40, panelHeight)

	local tempString = CurrentNode.data2
	love.graphics.setColor(MyColors[tempString])
	love.graphics.print(node.data4, love.graphics.getWidth() / 2, 200)
end

local function drawTree(node)
	local img = love.graphics.newImage(node.data3)
	-- love.graphics.draw(img, 0, 0)
	drawDial(node)
end

function love.load()
	print("\n")
	printTree(root)
end

function love.update(dt)
	suit.layout:reset(0, 500)
	suit.layout:col(love.graphics.getWidth() / 5, 30)
	if suit.Button("Bueton", suit.layout:col()).hit then
		CurrentNode = CurrentNode.children[1]
	end
	suit.layout:col()
	if suit.Button("Bueton2", suit.layout:col()).hit then
		CurrentNode = CurrentNode.children[2]
	end
	suit.layout:col()
end

function love.draw()
	drawTree(CurrentNode)
	suit.draw()
end

function love.keypressed(key)
	suit.keypressed(key)
end
