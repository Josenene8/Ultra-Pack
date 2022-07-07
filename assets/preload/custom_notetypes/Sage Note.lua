function onCreate()
	for i = 1,9 do
		precacheImage('v/tan/bait/pic'..tostring(i))
	end
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Sage Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'v/tan/sagenotes'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.23, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.0475'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has no penalties
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Sage Note' then

	end
end

-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen
function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'Sage Note' then
		local random = tostring(math.floor(math.random(1, 9)))
		local randomx = math.floor(math.random(630, 981))
		local randomy = math.floor(math.random(8, 500))
		makeLuaSprite('bait', 'v/tan/bait/pic'..random, randomx, randomy)
		setObjectCamera('bait', 'hud')
		addLuaSprite('bait', true)
		runTimer('fuckyou', 2)
	end
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'fuckyou' then
		removeLuaSprite('bait', false)
	end
end