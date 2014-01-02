/*
 *  Copyright (C) 2012-2013 Samsung Electronics Co., Ltd.
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version 2
 *  of the License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

/************************************************************************/
/*                                                                      */
/*  PROJECT : exFAT & FAT12/16/32 File System                           */
/*  FILE    : exfat_data.c                                              */
/*  PURPOSE : exFAT Configuable Data Definitions                        */
/*                                                                      */
/*----------------------------------------------------------------------*/
/*  NOTES                                                               */
/*                                                                      */
/*----------------------------------------------------------------------*/
/*  REVISION HISTORY (Ver 0.9)                                          */
/*                                                                      */
/*  - 2010.11.15 [Joosun Hahn] : first writing                          */
/*                                                                      */
/************************************************************************/

#include "exfat_config.h"
<<<<<<< HEAD
=======
#include "exfat_global.h"
>>>>>>> fc156d9... exFAT support
#include "exfat_data.h"
#include "exfat_oal.h"

#include "exfat_blkdev.h"
#include "exfat_cache.h"
#include "exfat_nls.h"
#include "exfat_super.h"
<<<<<<< HEAD
#include "exfat_core.h"
=======
#include "exfat.h"
>>>>>>> fc156d9... exFAT support

/*======================================================================*/
/*                                                                      */
/*                    GLOBAL VARIABLE DEFINITIONS                       */
/*                                                                      */
/*======================================================================*/

/*----------------------------------------------------------------------*/
/*  File Manager                                                        */
/*----------------------------------------------------------------------*/

<<<<<<< HEAD
=======
/* file system volume table */
FS_STRUCT_T fs_struct[MAX_DRIVE];

#if 0
>>>>>>> fc156d9... exFAT support
/*----------------------------------------------------------------------*/
/*  Buffer Manager                                                      */
/*----------------------------------------------------------------------*/

/* FAT cache */
<<<<<<< HEAD
DEFINE_SEMAPHORE(f_sem);
=======
DECLARE_MUTEX(f_sem);
>>>>>>> fc156d9... exFAT support
BUF_CACHE_T FAT_cache_array[FAT_CACHE_SIZE];
BUF_CACHE_T FAT_cache_lru_list;
BUF_CACHE_T FAT_cache_hash_list[FAT_CACHE_HASH_SIZE];

/* buf cache */
<<<<<<< HEAD
DEFINE_SEMAPHORE(b_sem);
BUF_CACHE_T buf_cache_array[BUF_CACHE_SIZE];
BUF_CACHE_T buf_cache_lru_list;
BUF_CACHE_T buf_cache_hash_list[BUF_CACHE_HASH_SIZE];
=======
DECLARE_MUTEX(b_sem);
BUF_CACHE_T buf_cache_array[BUF_CACHE_SIZE];
BUF_CACHE_T buf_cache_lru_list;
BUF_CACHE_T buf_cache_hash_list[BUF_CACHE_HASH_SIZE];
#endif

/* end of exfat_data.c */
>>>>>>> fc156d9... exFAT support
