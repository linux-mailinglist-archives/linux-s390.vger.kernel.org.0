Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A138FAE9
	for <lists+linux-s390@lfdr.de>; Tue, 25 May 2021 08:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhEYGbJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 25 May 2021 02:31:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230453AbhEYGbJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 02:31:09 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14P63Tta132495
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 02:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date : from
 : to : mime-version; s=pp1;
 bh=EbwinQp6mqNMnRqh63pNjOuCgGkHnhW0K+tN+wplhUc=;
 b=rH3z8QonK/ACYgIypZSUNb5PHEsVuLjCXC4ym7HruBgU0fNQ16pdjAbutpBHsrQT/jxV
 J7LKxRpEv6CtVqW0a9XlcN8S2qSS2eDsLOn3BptkKSuPo0mofHSfd4x+SoBijE8e37S2
 cX1DWrD+b+BbVZRLnYN3jR1WQbJbPSmV2iHvGrYFaYzfek5+XZJBVL4HYIHUwGHpzYPL
 KtpXMQD/F8+7pj2HTP7p2csHD6FGOY9gdZ5BdZy52G3plnx8cGQYIO17DkmNtIS90UF9
 Th0QXGUNgahyaGzZXEVNioVX4UxLhnZu2FWPGf3FZDf4fAPM2bz+dkCzFiri4xBh6+DD UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rqd3xk3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 02:29:40 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14P63wbD134514
        for <linux-s390@vger.kernel.org>; Tue, 25 May 2021 02:29:39 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38rqd3xk2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 02:29:39 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14P6TOUP017982;
        Tue, 25 May 2021 06:29:37 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 38psk88mha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 May 2021 06:29:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14P6TZGk21561740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 06:29:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0578A5204E;
        Tue, 25 May 2021 06:29:35 +0000 (GMT)
Received: from oc8242746057.ibm.com (unknown [9.171.79.73])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C940852052;
        Tue, 25 May 2021 06:29:34 +0000 (GMT)
Message-Id: <20210525062934.C940852052@d06av21.portsmouth.uk.ibm.com>
Date:   Tue, 25 May 2021 06:29:34 +0000 (GMT)
From:   egorenar@linux.ibm.com
To:     undisclosed-recipients:;
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Wno-jaCOVmKDiSAwba_tjRSm-UKuR4uD
X-Proofpoint-GUID: 1femDchG64kxoduEcoppTVTwcbMC1iJP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-25_03:2021-05-24,2021-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1011 mlxlogscore=234 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250043
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

XXXXX Alexander Egorenkov <egorenar@linux.ibm.com>
XXX Fabrice Fontaine <fontaine.fabrice@gmail.com>
XXX linux-s390@vger.kernel.org, fontaine.fabrice@gmail.com
XXX 
XXXXXXXX Re: [PATCH] arch/s390: disable SSP when needed
XXXXXXXXXXXX <20210510053133.1220167-1-fontaine.fabrice@gmail.com> (message
 XXXX Fabrice Fontaine on Mon, 10 May 2021 07:31:33 +0200)
XXXXXXXXXXXX 
XXXXX Tue, 25 May 2021 08:29:33 +0200
XXXXXXXXXXX <875yz7z5pu.fsf@oc8242746057.ibm.com>
XXXXXXXXXXXXX 1.0
XXXXXXXXXXXXX text/plain

XXXXXXX Fontaine <fontaine.fabrice@gmail.com> writes:

X Though -nostdlib is passed in PURGATORY_LDFLAGS and -ffreestanding in
X KBUILD_CFLAGS_DECOMPRESSOR, -fno-stack-protector must also be passed to
X avoid linking errors related to undefined references to
X '__stack_chk_guard' and '__stack_chk_fail' if toolchain enforces
X -fstack-protector.
X
X Fixes:
X  - https://gitlab.com/kubu93/buildroot/-/jobs/1247043361
X
X Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
X ---
X  arch/s390/Makefile           | 1 +
X  arch/s390/purgatory/Makefile | 1 +
X  2 files changed, 2 insertions(+)
X
X diff --git a/arch/s390/Makefile b/arch/s390/Makefile
X index e443ed9947bd..098abe3a56f3 100644
X --- a/arch/s390/Makefile
X +++ b/arch/s390/Makefile
X @@ -28,6 +28,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += XXXXXXXXXXXXXXXXXXXXXXXXXX -D__NO_FORTIFY
X  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float -mbackchain
X  KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
X  KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
X +KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
X  KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
X  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
X  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
X diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
X index c57f8c40e992..21c4ebe29b9a 100644
X --- a/arch/s390/purgatory/Makefile
X +++ b/arch/s390/purgatory/Makefile
X @@ -24,6 +24,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
X  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
X  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
X  KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
X +KBUILD_CFLAGS += -fno-stack-protector
X  KBUILD_CFLAGS += $(CLANG_FLAGS)
X  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
X  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))

XX Fabrice,

XXXX looks good to me.
XXXXX you for the patch.

XXXXXXXXXXXX Alexander Egorenkov <egorenar@linux.ibm.com>
Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Regards
Alex
