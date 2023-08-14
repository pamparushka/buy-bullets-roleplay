--
-- "SilahTürü" = { silahID, Mermi Miktarı, Fiyat}
local silahTurleri = {
	["pistol"]	= { 22, 17, 560 },
	["deagle"]	= { 24, 17, 670 },
	["silenced"]		= { 23, 17, 900 },
	["uzi"] 	= { 28, 25, 790 },
	["tec-9"]	= { 32, 25, 790 },
	["mp5"] 	= { 29, 25, 890 },
	["shotgun"]		= { 25, 10, 1200 },
	["ak-47"]	= { 30, 25, 1600 },
	["m4"]		= { 31, 25, 2500 },
	
}
colShape = createColSphere( 1424.9951171875, -1292.7138671875, 13.556790351868, 3)
setElementData(colShape, "mermiYeri", true)
function mermiBilgi(thePlayer, cmd)
	for index, colShape in ipairs(getElementsByType("colshape", resourceRoot)) do
		if getElementData(colShape, "mermiYeri") then
			if isElementWithinColShape(thePlayer, colShape) then
				local playerTeam = getPlayerTeam(thePlayer)
				local playerTeamType = getElementData(playerTeam, "type")
				if not playerTeam then
					outputChatBox(" >> #f0f0f0Herhangi bir birliğiniz yok!", thePlayer, 255, 0, 0, true)
					return false
				end
				if playerTeamType == 1 or playerTeamType == 0 then
					outputChatBox("#FF0000======================================", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFPISTOL:   17 Mermi (1 Şarjör) [560$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFDEAGLE:  17 Mermi (1 Şarjör) [670$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFSİLENCED:  17 Mermi (1 Şarjör) [900$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFUZI:           25 Mermi (1 Şarjör) [790$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFTEC-9:      25 Mermi (1 Şarjör) [790$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFMP5:         25 Mermi (1 Şarjör) [890$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFSHOTGUN:         10 Mermi (1 Şarjör) [1200$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFAK47:       25 Mermi (1 Şarjör) [1600$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFM4:           25 Mermi (1 Şarjör) [2500$]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000======================================", thePlayer, 255, 255, 255, true)
					outputChatBox("#66FF33/mermial #FFFFFFyazarak satin almayi gerceklestirebilirsiniz.", thePlayer, 255, 255, 255, true)
					outputChatBox("#66FF33/mermial #FFFFFFpistol 2 || yazarak 2 şarjor pistol mermisi alabilirsiniz.", thePlayer, 255, 255, 255, true)
				else
					outputChatBox(" >> #f0f0f0Bu işlemi yapabilmek için bir illegal birliğe dahil olmanız gerekmektedir!", thePlayer, 255, 0, 0, true)
				end
			end
		end
	end
end
addCommandHandler("mermi", mermiBilgi)

function mermiAl(thePlayer, cmd, silahTuru, sarjorMiktari)
    for index, colShape in ipairs(getElementsByType("colshape", resourceRoot)) do
        if getElementData(colShape, "mermiYeri") then
            if isElementWithinColShape(thePlayer, colShape) then
                local playerTeam = getPlayerTeam(thePlayer)
                local playerTeamType = getElementData(playerTeam, "type")
                if playerTeamType == 1 or playerTeamType == 0 then
                    if not silahTuru or not silahTurleri[string.lower(silahTuru)] or not sarjorMiktari then
                        outputChatBox(" >> #f0f0f0SÖZDİZİMİ: /" .. cmd .. " [Mermi Türü] [Şarjör Miktarı]", thePlayer, 255, 0, 0, true)
                        return false
                    end
                    if silahTurleri[string.lower(silahTuru)] then
                        local playerWeapons = getPedWeapons(thePlayer)
                        if not playerWeapons[1] then
                            outputChatBox(" >> #f0f0f0Bu mermiyi satın almak için uygun silahınız yok.", thePlayer, 255, 0, 0, true)
                            return false
                        end
                        
                        for index, weaponID in ipairs(playerWeapons) do
                            if weaponID == silahTurleri[string.lower(silahTuru)][1] then
                                local normalTutar = silahTurleri[string.lower(silahTuru)][3] * sarjorMiktari
                                local indirimliTutar = normalTutar

                                if getElementData(thePlayer, "vip") == 1 then
                                    indirimliTutar = math.floor(normalTutar * 0.95)  -- %5 indirim
                                end

                                outputChatBox(" >> #f0f0f0Toplam tutar: " .. indirimliTutar .. "TL Satışı onaylamak için /mermionayla, iptal etmek için /mermiiptal yazın!", thePlayer, 0, 0, 255, true)
                                setElementData(thePlayer, "mermi:tutar", indirimliTutar)
                                setElementData(thePlayer, "mermi:sarjorMiktari", sarjorMiktari)
                                setElementData(thePlayer, "mermi:silahTuru", silahTurleri[string.lower(silahTuru)][1])
                                setElementData(thePlayer, "mermi:mermiMiktari", silahTurleri[string.lower(silahTuru)][2])
                                return true
                            else
                                outputChatBox(" >> #f0f0f0Bu mermiyi satın almak için uygun silahınız yok.", thePlayer, 255, 0, 0, true)
                                return false
                            end
                        end
                    end
                end
            end
        end
    end
end
addCommandHandler("mermial", mermiAl)

function mermiOnayla(thePlayer, cmd)
	local mermiTutari = getElementData(thePlayer, "mermi:tutar")
	if mermiTutari then
		if exports.global:hasMoney(thePlayer, mermiTutari) then
			local sarjorMiktari = getElementData(thePlayer, "mermi:sarjorMiktari")
			local silahTuru = getElementData(thePlayer, "mermi:silahTuru")
			local mermiMiktari = getElementData(thePlayer, "mermi:mermiMiktari")
			
			exports.global:takeMoney(thePlayer, mermiTutari)
			for i = 1, sarjorMiktari do
				give, error = exports.global:giveItem(thePlayer, 116, silahTuru..":"..mermiMiktari..":Silah Mermisi "..getWeaponNameFromID(silahTuru))
			end
			setElementData(thePlayer, "mermi:tutar", false)
			setElementData(thePlayer, "mermi:sarjorMiktari", false)
			setElementData(thePlayer, "mermi:silahTuru", false)
			outputChatBox(" >> #f0f0f0Satış başarıyla gerçekleştirildi! " .. sarjorMiktari .. " Şarjör (" .. mermiMiktari .. ") için toplam " .. mermiTutari .. "TL ödediniz!", thePlayer, 0, 255, 0, true)
		else
			outputChatBox(" >> #f0f0f0Yeterli paranız yok!", thePlayer, 255, 0, 0, true)
		end
	end
end
addCommandHandler("mermionayla", mermiOnayla)

function mermiIptal(thePlayer, cmd)
	local mermiTutari = getElementData(thePlayer, "mermi:tutar")
	if mermiTutari then
		setElementData(thePlayer, "mermi:tutar", false)
		setElementData(thePlayer, "mermi:sarjorMiktari", false)
		setElementData(thePlayer, "mermi:silahTuru", false)
		outputChatBox(" >> #f0f0f0Satışı başarıyla iptal ettiniz!", thePlayer, 0, 255, 0, true)
	end
end
addCommandHandler("mermiiptal", mermiIptal)

-- NECKTROX
function getPedWeapons(ped)
    local weaponList = {}
 
    for i = 0, 12 do
        local weaponID = getPedWeapon(ped, i)
 
        if weaponID ~= 0 then
            table.insert(weaponList, weaponID)
        end
    end
   
    return weaponList
end
