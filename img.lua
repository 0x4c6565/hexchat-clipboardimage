-- I apologise profoundly for the following

hexchat.register("img.lee.io plugin", "0.1", "An horrendous plugin to upload images from the clipboard to img.lee.io")

local function img(data)
    local p = io.popen("ImageUploader.exe")
    local std_out = p:read('*l')
    p:close()

    if (std_out == nil) then
        hexchat.print("Unexpected nil response from ImageUploader - check path")
        return
    end

    -- this is just terrible - cannot access exitcode with io.popen (and only exitcode with os.execute), so lets check by just regexing out a URL instead
    if (std_out:match("^(http)")) then
        hexchat.command("say " .. std_out)
    else
        hexchat.print("Error: " .. std_out)
    end

    return hexchat.EAT_HEXCHAT
end

local function unload()
    hexchat.print("Unloading img.lee.io plugin")
end

hexchat.hook_command("img", img)
hexchat.hook_unload(unload)

hexchat.print("Loaded img.lee.io plugin")
