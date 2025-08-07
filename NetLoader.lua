-- NetLoader.lua
-- Custom Luarmor loader (cleaned, no Discord)

_bsdata0 = {
    {{2955209245,1754598273,90585},998782318,785507,"\241\0\0\0",
    "ED1EB5E!A210!3!6F3!4!5C621EA4F3B-HC-!-204D4012AE!D3FC--1E6A!!FAE5HE3BBD23!662CC5F1DC5A0!E4H0D-5!1052CEC2BF-5HFBAE!CEHE26",
    "62d7f2e0096d6265d37527df325db0598dafdfecb437f640b8ae5e740574e06af9f5921a246aa3ae70e3a5925a0a8475cdf2f6f84f47567bce2cb2c82d9b25f453d09d1c7226bf54d6c508e77392ef158fd508f2422dd6b4db5cce3eb69fab045e8b99fad96dd3487ca1bcc8ad565613d9b5060d80c8ed1af5d581da9c4d76ea60dade401820f5c37b4e572c6a7f6756cc7109e01499afaf0a5300e8b0932be090a07812b40d88fea635c8520622be8eb11439284c405169c3adf58c647a7d3247bc36513be1a252"}
};

-- Clean up cached file
pcall(function()
    delfile("bf15a15feb3e074f81db01496cbb48e2-cache.lua")
end)

-- Try to load local cache
local a
pcall(function()
    a = readfile("static_content_130525/initv4.lua")
end)

-- If cache is valid, run it
if a and #a > 2000 then
    a = loadstring(a)
end

-- Otherwise fetch fresh version
if a then
    return a()
else
    pcall(makefolder, "static_content_130525")
    a = game:HttpGet("https://cdn.luarmor.net/v4_init_may312.lua")
    writefile("static_content_130525/initv4.lua", a)
    pcall(delfile, "static_content_130525/init.lua")
    pcall(delfile, "static_content_130525/initv2.lua")
    pcall(delfile, "static_content_130525/initv3.lua")
    loadstring(a)()
end
