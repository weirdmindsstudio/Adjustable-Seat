Vector = Vector or {}
Space = Space or {}

channel = 'seat.adjustable'

settings = settings or {}

logger = {enabled = false}
logger.log = function(logEntry, data)
    if logger.enabled then
        local payload = ''
        if data ~= nil then
            if type(data) == 'table' then
                if json ~= nil then
                    payload = ' - (table) length: ' .. tostring(#data) .. ' - values: ' .. json.serialize(data)
                else
                    payload = ' - (table) length: ' .. tostring(#data) .. ' - values: (no json) ' .. tostring(data)
                end
            else
                payload = ' - ' .. tostring(data)
            end
        end
        Space.Log(string.format('%09.4f', getTime()) .. ' - SEAT - ' .. logEntry .. payload, true)
    end
end

function isEditor()
    -- return false
    return Space.RuntimeType ~= 'Server'
end

function getTime()
    local time
    if isEditor() then
        time = Space.Time
    else
        time = Space.ServerTimeUnix
    end
    return time
end

function sendAll(data)
    logger.log('sendAll', data)
    if isEditor() then
        Space.Network.SendNetworkMessage(channel, data)
    else
        Space.SendMessageToAllClientScripts(channel, data)
    end
end

function sendOne(id, data)
    logger.log('sendOne', {id, data})
    if isEditor() then
        Space.Network.SendNetworkMessage(channel, data)
    else
        Space.SendMessageToClientScripts(id, channel, data)
    end
end

function processMessage(data)
    logger.log('processMessage', data)
    if data.command == 'getConfig' then
        if settings ~= nil and settings[data.source] ~= nil then
            local update = {}
            update.command = 'setConfig'
            update.target = data.source
            update.settings = settings[data.source]
            sendOne(data.player, update)
        elseif isEditor then
            local update = {}
            update.command = 'setConfig'
            update.target = data.source
            update.settings = {}
            sendOne(data.player, update)
        end
    elseif data.command == 'storeConfig' then
        if settings == nil then
            settings = {}
        end
        settings[data.source] = data.settings

        local update = {}
        update.command = 'setConfig'
        update.target = data.source
        update.settings = settings[data.source]
        sendAll(update)

        logger.log('storing settings', settings)
        Space.Database.SetRegionValue(channel, json.serialize(settings), onSetRegionValue)
    end
end

function onEditorRecieve(message)
    logger.log('onEditorRecieve', message)
    processMessage(message.Arguments)
end

function onServerRecieve(message)
    logger.log('onServerRecieve', message)
    processMessage(message.Arguments)
end

function onSetRegionValue(result)
    logger.log('onSetRegionValue', result)
end

function onGetRegionValue(data)
    logger.log('onGetRegionValue', data)
    settings = json.parse(data)
end

function OnScriptServerMessage(channelInput, arguments)
    if channelInput == channel then
        logger.log('OnScriptServerMessage', {channel, arguments})
        processMessage(arguments)
    end
end

function init()
    logger.log('starting up')
    if isEditor() then
        logger.log('editor mode, channel', channel)
        settings = {}
        Space.Network.SubscribeToNetwork(channel, onEditorRecieve)
    else
        logger.log('server mode, channel', channel)
        Space.Database.GetRegionValue(channel, onGetRegionValue)
        Space.SubscribeToNetwork(channel)
    end
    logger.log('startup complete')
end

init()
