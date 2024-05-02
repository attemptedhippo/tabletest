-- Define the N-ary tree node
local Node = {}
Node.__index = Node

function Node.new(data1, data2)
	local self = setmetatable({}, Node)
	self.data1 = data1
	self.data2 = data2
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
local root = Node.new("\nRoot", "Red")
local child1 = Node.new("Child 1", "Blue")
local child2 = Node.new("Child 2", "Blue")
local child3 = Node.new("Child 3", "Yellow")
local child4 = Node.new("Child 4", "Green")
local child5 = Node.new("Child 5", "Green")
local child6 = Node.new("Child 6", "Yellow")
local child7 = Node.new("Child 7", "Yellow")

root:addChild(child1)
root:addChild(child2)
child2:addChild(child3)
child3:addChild(child4)
child3:addChild(child5)
child1:addChild(child6)

-- Print the tree (depth-first traversal)
local function printTree(node, depth)
	depth = depth or 0
	print(("  "):rep(depth) .. node.data1 .. ":" .. node.data2)
	for _, child in ipairs(node.children) do
		printTree(child, depth + 1)
	end
end

function love.load()
	printTree(root)
end
