Return-Path: <linux-s390+bounces-123-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE127F612F
	for <lists+linux-s390@lfdr.de>; Thu, 23 Nov 2023 15:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C366281E66
	for <lists+linux-s390@lfdr.de>; Thu, 23 Nov 2023 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177912D608;
	Thu, 23 Nov 2023 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JfXIJVS+"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D0D40;
	Thu, 23 Nov 2023 06:13:41 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANDod0w013391;
	Thu, 23 Nov 2023 14:13:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=Q04AXgHuRqcJadhMlb2LUeTbuaDdTSUNd6AIPrTaYzs=;
 b=JfXIJVS+F5prnqDH5sAiQ9lg5miS4D82vC5tSM6gib0Y98dn3HrL9O1y/TGEqOSx/Bq1
 VXrNP9rDZaFClNNyF/qqdE9CzPQ7WAc3sTHgOoowVKb6qQ6E6v17vgSA3i1pl6dpGlo6
 nJfgnUx53i6tUPKFyXa7Bhs6ARh06vWKPCOIGelxuG31lh1gNGvSnMVK5gZaWPpVtBzk
 f3UagDvuCcO7Zkb4XeGEcWVO/QojqyFtnMaHjrOk/nKHHA29JA1j3IyhVUU7bQagRrkR
 RsSlatuUx+CdWWn/bBPO2TRR4r6YF8n3jfeUBODSLWuS7GPPUI69BrSzoPuZTZ3lxP+b lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj7dpsh8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 14:13:34 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ANDomMR014492;
	Thu, 23 Nov 2023 14:13:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uj7dpsh87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 14:13:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANBIqBa024672;
	Thu, 23 Nov 2023 14:13:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8kp7jkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Nov 2023 14:13:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ANEDVjF45548276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Nov 2023 14:13:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB5E62004B;
	Thu, 23 Nov 2023 14:13:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B37820040;
	Thu, 23 Nov 2023 14:13:30 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.80.84])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Nov 2023 14:13:30 +0000 (GMT)
Date: Thu, 23 Nov 2023 15:13:28 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        akpm@linux-foundation.org, ignat@cloudflare.com,
        eric_devolder@yahoo.com
Subject: Re: [PATCH 2/3] drivers/base/cpu: crash data showing should depends
 on KEXEC_CORE
Message-ID: <ZV9eCBm5uy7/VgOX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20231123073652.507034-1-bhe@redhat.com>
 <20231123073652.507034-3-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123073652.507034-3-bhe@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2VLVSyf8Y0jVaqlYYFYjpVvyoOJkyXHF
X-Proofpoint-ORIG-GUID: FbY8vbpibFUL3rG1mgZJQiwJNhj6l0VL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=642
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311230102

On Thu, Nov 23, 2023 at 03:36:51PM +0800, Baoquan He wrote:
> When below kernel config items are set, compiling error are triggered.
> 
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> CONFIG_CRASH_HOTPLUG=y
> 
> ------------------------------------------------------
> drivers/base/cpu.c: In function ‘crash_hotplug_show’:
> drivers/base/cpu.c:309:40: error: implicit declaration of function ‘crash_hotplug_cpu_support’; did you mean ‘crash_hotplug_show’? [-Werror=implicit-function-declaration]
>   309 |         return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
>       |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                        crash_hotplug_show
> cc1: some warnings being treated as errors
> ------------------------------------------------------
> 
> CONFIG_KEXEC is used to enable kexec_load interface, the
> crash_notes/crash_notes_size/crash_hotplug showing depends on
> CONFIG_KEXEC is incorrect. It should depend on KEXEC_CORE instead.
> 
> Fix it now.

If this error introduced with the prevous patch?
If so, the patches need to be swapped I guess.

> Signed-off-by: Baoquan He <bhe@redhat.com>

