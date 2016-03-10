#ifndef XGTASKMANAGER_H
#define XGTASKMANAGER_H

#include <XgWinExport.h>
#include <tbb/mutex.h>

class XGEN_EXPORT XgTaskManager
{
public:
	static tbb::mutex& globalMutex();	// Turbo: lock for debugging/prototyping

	static size_t taskGrainSize(size_t jobCount);

	static bool multithreadingEnabled();
	static void setMultithreading(bool state);
	static void setPatchMultithreading(bool state);
	static void setCollisionMultithreading(bool state);
	static void setSeExprMultithreading(bool state);

	static void setPtexCacheSize(size_t size);
	static size_t ptexCacheSize();
};

#define XG_TASK_GLOBAL_LOCK tbb::mutex::scoped_lock lock(XgTaskManager::globalMutex())

#endif

// ==================================================================
// Copyright 2014 Autodesk, Inc.  All rights reserved.
// 
// This computer source code  and related  instructions and comments are
// the unpublished confidential and proprietary information of Autodesk,
// Inc. and are  protected  under applicable  copyright and trade secret
// law. They may not  be disclosed to, copied or used by any third party
// without the prior written consent of Autodesk, Inc.
// ==================================================================
