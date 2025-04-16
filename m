Return-Path: <linux-s390+bounces-10062-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B31DDA905AF
	for <lists+linux-s390@lfdr.de>; Wed, 16 Apr 2025 16:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8FD19E5256
	for <lists+linux-s390@lfdr.de>; Wed, 16 Apr 2025 14:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2D22087;
	Wed, 16 Apr 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KIVn4wio"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A71FBEA9
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811890; cv=none; b=ZBe08oBq58MQQvIEsCGe7b4Elygmp7OkHn2xQbt0kftxcVq3NK9HobAmh0I/Z24Ga+lMYV4URRPJArNxfOOCu3cIF/fdtU5I/WTBcpQI1F86e/LySYtevN2xlz8/wsHO+cWqNKR4dskDR8iy3Pxvw+O0egPiunsv0w+DOXNHnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811890; c=relaxed/simple;
	bh=0U9YAE6AT6+78Es2JwrdSKtG/8urIbAA81Qc9rQ7sR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNGBPFZvvdGHPbvQax6OtbBWG1WyIhgH5yj49nqToL20rP5jjrHSRO/OHHYy1viOd0XpzQ8SAL/XDz8MGDncXKbFfvIIkm58GmbFLtMQrvZzY0i8pO9aauqGG4BKEjowixelVuaWIzS6OAlkAVakB2AzQTa9FEBgU2bky16HaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KIVn4wio; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GA3sJQ028924;
	Wed, 16 Apr 2025 13:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WC+oTw6vPTQg9k1m1vAipII6+CsNyDXEsqWMjSzFQ
	Ng=; b=KIVn4wioYad50/1Wekj4d3vZSz+lxVSDFmoPri6G6yBjp3tiJZo46vX5C
	lWMsQu2NRJd8iglohsXutxTUM4jhmL1oDKDQz3PLgsVZsTuoNRvDZltCOqh40qFw
	6zxXdT19THgdoQkCfjy4gJ6vVVFYV9DINADsHhDPEGdor6bSDeF519BwOh1EOCCs
	NUjiAcSlLdmOjHzXphC4AMgPI1pPYgUJ5V4FEjYOnJ7qCdnYL1VuU5UpBZ4ZGyxS
	HnI2nP6ZAkwD9p25TwfUWlb/QNw8b6Bb/fdsRdl1CR8AF6xuQQAnr3fKRRhaHEzI
	We6PPgparPquvjhfrhb1dDuDLvS1Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462aff97gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GCN2Jw016431;
	Wed, 16 Apr 2025 13:58:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460572882f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:05 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDw2Dl41091400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00EB820043;
	Wed, 16 Apr 2025 13:58:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B11B20040;
	Wed, 16 Apr 2025 13:58:01 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:01 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 00/25] AP bus/zcrypt/pkey/paes no-mem-alloc patches
Date: Wed, 16 Apr 2025 15:57:35 +0200
Message-ID: <20250416135801.133909-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nx6m4v1DbeP2aSTXno1xwhxm6Z3IYCJc
X-Proofpoint-GUID: Nx6m4v1DbeP2aSTXno1xwhxm6Z3IYCJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504160111

This series of patches has the goal to open up a do-not-allocate
memory path from the callers of the pkey in-kernel api down to
the crypto cards and back.

The asynch in-kernel cipher implementations (and the s390 PAES
cipher implementations are one of them) may be called in a
context where memory allocations which trigger IO is not acceptable.

So this patch series reworks the AP bus code, the zcrypt layer,
the pkey layer and the pkey handlers to respect this situation
by processing a new parameter xflags (execution hints flags).
There is a flag PKEY_XFLAG_NOMEMALLOC which tells the code to
not allocate memory which may lead to IO operations.

To reach this goal, the actual code changes have been differed.
The zcrypt misc functions which need memory for cprb build
use a pre allocated memory pool for this purpose. The findcard()
functions have one temp memory area preallocated and protected
with a mutex. Some smaller data is not allocated any more but went
to the stack instead. The AP bus also uses a pre-allocated
memory pool for building AP message requests.

Note that the PAES implementation still needs to get reworked
to run the protected key derivation in a real asynchronous way.
However, this rework of AP bus, zcrypt and pkey is the base work
required before reconsidering the PAES implementation.

The patch series starts bottom (AP bus) and goes up the call
chain (PKEY). At any time in the patch stack it should compile.
For easier review I tried to have one logic code change by
each patch and thus keep the patches "small". For the upstream
version I intend to fold them together into only a few commits.

Changelog:
v1: initial version
v2: - Rework on patch 0001 and 0002 based on feedback from Holger.
      Also there was one place in zcrypt_msgtype50.c where still
      an ap msg buffer was alloacated.
    - Rework on patch 0003 - fixed feedback from Holger. Also the
      min poolitems is now a module parameter and defaults to 8.
    - Rework on patch 0004 - as suggested by Holger the "userspace"
      parameter is now included into the ap msg flags.
    - Rework on patch 0005 - nr of cca cprbs in the mempool is now
      a module parameter.
    - Rework on patch 0006 - nr of ep11 cprbs in the mempool is now
      a module parameter.
    - Rework on patch 0007 - as suggested by Holger instead of
      implementing a copy-and-pasted new function
      zcrypt_device_status_mask_ext2() use and extend the existing
      the existing function to avoid code duplication.
    - The rest of the patch series needed adaptions but there is
      no functional change compared to v1.
v3: Rework based on feedback from Holger:
    - There is now one zcrypt module parameter "mempool_threshold"
      controlling the cprb mempools for CCA and EP11. The default
      value of 5 shall cover 5 CCA or EP11 requests/replies in parallel.
    - The cca and ep11 card and domain info cache is done - anyway
      nearly all callers used the verify=1 to enforce the retrieval
      of fresh information. So now this info is always freshly fetched
      from the card/domain.
    - Holger found out that there are some unused functions lurking
      around - deleted :-)
    - The only thing still missing is no-mem support for the UV
      driver. As of now the pkey uv layer refuses to contact the UV
      dd in case the NOMEMALLOC flag is given.
    - Tested and found no issues.
v4: Still some minor changes:
    - The UV patch is now part of this patch series
    - With that came a slight rework of the pkey uv handler code.
      It is now pre-allocating one struct for use with the UV driver.
    - The zcrypt api module parameter mempool_threshold is now
      checked and enforced to have at least a value of 1.
    - Heiko found some things, for example the mempool_create()
      was for some reason checking for PTR_ERR which does not apply to
      the used way of creating the mempools - fixed in all patches.
    - Heiko also had the question about the artificial limit of
      16 APQNs as target addressing for EP11 cprbs. Together with
      Holger we found out, that this is not needed at all - so yet
      another patch now reworks this code (see patch "s390/zcrypt:
      Avoid alloc and copy of ep11 targets if kernelspace cprb").
v5: - new patch for the uv code to support another non-malloc
      interface function ("s390/uv: Rename find_secret() to
      uv_find_secret() and publish")
    - with that a slight rework of the pkey uv handler which is
      now able to retrieve uv protected key secrets without malloc.
    - new patch for the uv code to remove the old interface function
      ("s390/uv: Remove uv_get_secret_metadata function").
    - Lots of minor reworks triggered by review comments from
      Holger.
v6: - Typo in patch header and other patch header text improvements
      fixed
    - zero page to be used for uv before calling
      uv_find_secret().
    - added the latest signed-offs
    - tested, looks good

Harald Freudenberger (25):
  s390/ap: Move response_type struct into ap_msg struct
  s390/ap/zcrypt: Rework AP message buffer allocation
  s390/ap: Introduce ap message buffer pool
  s390/zcrypt: Avoid alloc and copy of ep11 targets if kernelspace cprb
  s390/ap/zcrypt: New xflag parameter
  s390/zcrypt: Introduce cprb mempool for cca misc functions
  s390/zcrypt: Introduce cprb mempool for ep11 misc functions
  s390/zcrypt: Rework zcrypt function zcrypt_device_status_mask_ext
  s390/zcrypt: Introduce pre-allocated device status array for cca misc
  s390/zcrypt: Introduce pre-allocated device status array for ep11 misc
  s390/zcrypt: Remove unused functions from cca misc
  s390/zcrypt: Remove CCA and EP11 card and domain info caches
  s390/zcrypt: Rework cca findcard() implementation and callers
  s390/zcrypt: Rework ep11 findcard() implementation and callers
  s390/zcrypt: Rework cca misc functions kmallocs to use the cprb
    mempool
  s390/zcrypt: Propagate xflags argument with cca_get_info()
  s390/zcrypt: Locate ep11_domain_query_info onto the stack instead of
    kmalloc
  s390/zcrypt: Rework ep11 misc functions to use cprb mempool
  s390/pkey: Rework CCA pkey handler to use stack for small memory
    allocs
  s390/pkey: Rework EP11 pkey handler to use stack for small memory
    allocs
  s390/uv: Rename find_secret() to uv_find_secret() and publish
  s390/pkey: Use preallocated memory for retrieve of UV secret metadata
  s390/uv: Remove uv_get_secret_metadata function
  s390/pkey: Provide and pass xflags within pkey and zcrypt layers
  s390/pkey/crypto: Introduce xflags param for pkey in-kernel API

 arch/s390/crypto/paes_s390.c           |   6 +-
 arch/s390/include/asm/pkey.h           |  15 +-
 arch/s390/include/asm/uv.h             |   5 +-
 arch/s390/kernel/uv.c                  |  47 +--
 drivers/s390/crypto/ap_bus.c           |  74 ++++
 drivers/s390/crypto/ap_bus.h           |  30 +-
 drivers/s390/crypto/pkey_api.c         |  50 +--
 drivers/s390/crypto/pkey_base.c        |  34 +-
 drivers/s390/crypto/pkey_base.h        |  37 +-
 drivers/s390/crypto/pkey_cca.c         | 134 ++++---
 drivers/s390/crypto/pkey_ep11.c        | 117 +++---
 drivers/s390/crypto/pkey_pckmo.c       |   9 +-
 drivers/s390/crypto/pkey_sysfs.c       |   4 +-
 drivers/s390/crypto/pkey_uv.c          |  44 ++-
 drivers/s390/crypto/zcrypt_api.c       | 164 ++++++---
 drivers/s390/crypto/zcrypt_api.h       |  16 +-
 drivers/s390/crypto/zcrypt_ccamisc.c   | 484 +++++++++----------------
 drivers/s390/crypto/zcrypt_ccamisc.h   |  49 +--
 drivers/s390/crypto/zcrypt_cex4.c      |  39 +-
 drivers/s390/crypto/zcrypt_ep11misc.c  | 452 +++++++++++------------
 drivers/s390/crypto/zcrypt_ep11misc.h  |  27 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  36 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  | 109 +++---
 23 files changed, 959 insertions(+), 1023 deletions(-)


base-commit: bffb31040cb61aa72de8ffac655fe1459d581505
--
2.43.0


