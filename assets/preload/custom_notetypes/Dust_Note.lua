function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Fire Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Dust_Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'custom_notetypes/Dust_Note'); --Change texture --Change note splash texture
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashHue', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashSat', 0);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashBrt', -100);
			--setPropertyFromGroup('unspawnNotes', i, 'x', getPropertyFromGroup('unspawnNotes', i, 'x')-166);

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Lets Opponent's instakill notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			else
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			end
		end
	end

	precacheSound('dust');
	precacheImage('dust');
end
function onCreatePost()
	makeLuaSprite('dust', 'dust', 0, 0);
	setObjectCamera('dust', 'camhud');
	setProperty('dust.alpha', 0.001);
	addLuaSprite('dust', true);
	runTimer('dustdisable', 0.01);
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
local dustAccumulated = 0;
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Dust_Note' then
		dustAccumulated = dustAccumulated + 1;
		setProperty('dust.alpha', dustAccumulated / 10);
		if dustAccumulated > 9 then
			setHealth(0); -- death
		end
		runTimer('dust_disappear', 35);
		playSound('dust', 1, 'dustsound');
	end
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'dustdisable' then
		setProperty('dust.alpha', 0);
	end
	if tag == 'dust_disappear' then
		dustAccumulated = dustAccumulated - 1;
		setProperty('dust.alpha', dustAccumulated / 10);
	end
end