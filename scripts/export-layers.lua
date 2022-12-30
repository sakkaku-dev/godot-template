-- Export each layer as sprite sheet
-- Ignoring layers starting with "_"
--
-- Group layers will be exported as one sprite
-- except then it starts with ">" then it's exported like there isn't a group layer

function string:startswith(start)
    return self:sub(1, #start) == start
end

local function makesAllLayersVisible(layers, visible)
    for index, layer in ipairs(layers) do
        layer.isVisible = visible
        if layer.isGroup then
            makesAllLayersVisible(layer.layers)
        end
    end
end

local function exportLayer(layer, output, col)
    app.command.ExportSpriteSheet {
        type = SpriteSheetType.ROWS,
        textureFilename = output,
        layer = layer.name,
        trimSprite = true,
        trimByGrid = true,
        ignoreEmpty = true,
        columns = col,
    }
end

local function exportGroupLayer(layer, output, col)
    layer.isVisible = true
    makesAllLayersVisible(layer.layers, true)

    app.command.ExportSpriteSheet {
        type = SpriteSheetType.ROWS,
        textureFilename = output,
        trimSprite = true,
        trimByGrid = true,
        ignoreEmpty = true,
        columns = col,
    }

    layer.isVisible = false
    makesAllLayersVisible(layer.layers, false) 
end

local function tryExportLayers(layers, dir, col)
    for _, layer in ipairs(layers) do
        if not layer.name:startswith('_') then
            local output = dir .. '/' .. layer.name .. '.png'
            if layer.layers then
                if layer.name:startswith('>') then
                    tryExportLayers(layer.layers, dir, col)
                else
                    exportGroupLayer(layer, output, col)
                end
            else
                exportLayer(layer, output, col)
            end
        end
    end
end


local file = app.params['file']
local dir = app.params['dir']
local col = app.params['col']

if file and dir then
    local full_path = dir .. '/' .. file
    local sprite = app.open(full_path)

    makesAllLayersVisible(sprite.layers, false)
    tryExportLayers(sprite.layers, dir, col)
end
