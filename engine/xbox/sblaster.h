/*
 * OpenBOR - https://www.chronocrash.com
 * -----------------------------------------------------------------------
 * Licensed under the BSD license, see LICENSE in OpenBOR root for details.
 *
 * Copyright (c)  OpenBOR Team
 */

#ifndef SBLASTER_H
#define SBLASTER_H

#define		MAXDMABUFSIZE	0x10000
#define		MONO		0
#define		STEREO		1
#define		LOWQ		0
#define		HIGHQ		2
#define		SBDETECT	-1

#define		SB_MASTERVOL	0x22
#define		SB_VOICEVOL	0x04
#define		SB_CDVOL	0x28

// The interface

int SB_playstart(int bits, int samplerate);
void SB_playstop();
char SB_getvolume(char dev);
char SB_setvolume(char dev, char volume);


#endif
