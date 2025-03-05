GameEventManager = {}

local _innerListenerPool = {}

function GameEventManager.AddListener(eventName, func, tag)
	assert(tag, "Tag must not be nil")

	if not _innerListenerPool[eventName] then
		_innerListenerPool[eventName] = {}
	end

	local eventListeners = _innerListenerPool[eventName]
	for i = 1, #eventListeners do
		if tag == eventListeners[i][2] then
			return
		end
	end

	eventListeners[#eventListeners+1] = {func, tag}
end

function GameEventManager.Remove(func)
	for eventName, eventListeners in pairs(_innerListenerPool) do
		for i = #eventListeners, 1, -1 do
			if eventListeners[i][1] == func then
				table.remove(eventListeners, i)
				if 0 == #_innerListenerPool[eventName] then
					_innerListenerPool[eventName] = nil
				end
				return
			end
		end
	end
end

function GameEventManager.RemoveByNameAndTag(eventName, tag)
	assert(tag, "Tag must not be nil")
	local eventListeners = _innerListenerPool[eventName]
	if not eventListeners then return end

	for i = #eventListeners, 1, -1 do
		if eventListeners[i][2] == tag then
			table.remove(eventListeners, i)
			break
		end
	end

	if 0 == #eventListeners then
		_innerListenerPool[eventName] = nil
	end
end

function GameEventManager.RemoveByTag(tag)
	assert(tag, "Tag must not be nil")
	for eventName, eventListeners in pairs(_innerListenerPool) do
		GameEventManager.removeByNameAndTag(eventName, tag)
	end
end

function GameEventManager.RemoveAll()
	_innerListenerPool = {}
end

function GameEventManager.DoTriggerEvent(eventName, ...)
	local eventListeners = _innerListenerPool[eventName]
	if not eventListeners then
		return
	end

	for _, listener in pairs(eventListeners) do
		local result, stop = pcall(listener[1], ...)
		if result then
			if stop then break end
		else
			local tag = listener[2]
			local tagid = tag or 0
			local err = "DoTriggerEvent Error£ºeventName="..eventName.."  TagID="..tagid.."  [==========]"
			release_print(err, stop)
		end
	end
end

return GameEventManager