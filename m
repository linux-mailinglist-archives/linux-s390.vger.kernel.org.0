Return-Path: <linux-s390+bounces-554-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6768118E0
	for <lists+linux-s390@lfdr.de>; Wed, 13 Dec 2023 17:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46CFE28251E
	for <lists+linux-s390@lfdr.de>; Wed, 13 Dec 2023 16:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78DE3159A;
	Wed, 13 Dec 2023 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UmN/vA+M"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F34116;
	Wed, 13 Dec 2023 08:14:07 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDFNDZf027077;
	Wed, 13 Dec 2023 16:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=NQjuEkFf7a8W/rWN1ejAa3l7PgiYJl/ycpBcrDEw/hM=;
 b=UmN/vA+M1Fz2JktBdSmF3h2qYe+4xyEUeJtnMG4EkvUplKxVgcQsuj8tOkNwYEGJOF1O
 IGBXpZxR8/E7p3KRteLCZ5MLMPd2nG0kt+/pqRRaxt8fGvDg62hlcpAHCmnXaSEgFdaU
 JJKueaqxovf1sVKSXi3dxhwzY+CedyI28Q+Zl0eBN61E8MfeOX1JlkLESKDToUorj2g1
 TIAZ7fWq7mO4X4noqkFmDDxBXSagvkH0HP/jD93+OUd4lW3xqA77vN5CSSQT4DK/uJAp
 mAHylKp2E2wkw5Pg+JBLC2ns9Y9xC9BPFqBg3pKCar4m6pLEIBSnED4zMPLWuItsFlc4 mQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyf729msr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 16:13:56 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDFOPKQ029752;
	Wed, 13 Dec 2023 16:13:56 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyf729mrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 16:13:56 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDG0Dw2004139;
	Wed, 13 Dec 2023 16:13:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4skhn2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 16:13:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDGDqfq14156408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 16:13:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CFF220043;
	Wed, 13 Dec 2023 16:13:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2BE920040;
	Wed, 13 Dec 2023 16:13:50 +0000 (GMT)
Received: from [9.179.18.31] (unknown [9.179.18.31])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Dec 2023 16:13:50 +0000 (GMT)
Message-ID: <8d118a94-945f-466f-9d34-e0b8a6d8a9e7@linux.ibm.com>
Date: Wed, 13 Dec 2023 17:13:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 00/10] net/smc: implement SMCv2.1 virtual ISM
 device support
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        wenjia@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, kgraul@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, lzinux-kernel@vger.kernel.org
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sfgcn5VdaNpRykmdy9c6ml3Q82cr4Dn8
X-Proofpoint-GUID: _KM_dhMcIQMKhVZajh5D5uS_n7bAlfV5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_09,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 spamscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130115



On 12/12/2023 09:52, Wen Gu wrote:
> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
> OS or hypervisor software, comparable to IBM ISM which is based on platform
> firmware or hardware.
> 
> With the introduction of virtual ISM, SMCv2.1 makes some updates:
> 
> - Introduce feature bitmask to indicate supplemental features.
> - Reserve a range of CHIDs for virtual ISM.
> - Support extended GIDs (128 bits) in CLC handshake.
> 
> So this patch set aims to implement these updates in Linux kernel. And it
> acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].
> 
> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/

FYI I'm currently reviewing this version of the series.
Hope to give you feedback by the end of tomorrow.

Thanks for your effort
- Jan


> 
> v6->v5:
> - Add 'Reviewed-by' label given in the previous versions:
>    * Patch #4, #6, #9, #10 have nothing changed since v3;
> - Patch #2:
>    * fix the format issue (Alignment should match open parenthesis) compared to v5;
>    * remove useless clc->hdr.length assignment in smcr_clc_prep_confirm_accept()
>      compared to v5;
> - Patch #3: new added compared to v5.
> - Patch #7: some minor changes like aclc_v2->aclc or clc_v2->clc compared to v5
>    due to the introduction of Patch #3. Since there were no major changes, I kept
>    the 'Reviewed-by' label.
> 
> Other changes in previous versions but not yet acked:
> - Patch #1: Some minor changes in subject and fix the format issue
>    (length exceeds 80 columns) compared to v3.
> - Patch #5: removes useless ini->feature_mask assignment in __smc_connect()
>    and smc_listen_v2_check() compared to v4.
> - Patch #8: new added, compared to v3.
> 
> v5->v4:
> - Patch #6: improve the comment of SMCD_CLC_MAX_V2_GID_ENTRIES;
> - Patch #4: remove useless ini->feature_mask assignment;
> 
> v4->v3:
> - Patch #6: use SMCD_CLC_MAX_V2_GID_ENTRIES to indicate the max gid
>    entries in CLC proposal and using SMC_MAX_V2_ISM_DEVS to indicate the
>    max devices to propose;
> - Patch #6: use i and i+1 in smc_find_ism_v2_device_serv();
> - Patch #2: replace the large if-else block in smc_clc_send_confirm_accept()
>    with 2 subfunctions;
> - Fix missing byte order conversion of GID and token in CLC handshake,
>    which is in a separate patch sending to net:
>    https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/
> - Patch #7: add extended GID in SMC-D lgr netlink attribute;
> 
> v3->v2:
> - Rename smc_clc_fill_fce as smc_clc_fill_fce_v2x;
> - Remove ISM_IDENT_MASK from drivers/s390/net/ism.h;
> - Add explicitly assigning 'false' to ism_v2_capable in ism_dev_init();
> - Remove smc_ism_set_v2_capable() helper for now, and introduce it in
>    later loopback-ism implementation;
> 
> v2->v1:
> - Fix sparse complaint;
> - Rebase to the latest net-next;
> 
> Wen Gu (10):
>    net/smc: rename some 'fce' to 'fce_v2x' for clarity
>    net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
>    net/smc: unify the structs of accept or confirm message for v1 and v2
>    net/smc: support SMCv2.x supplemental features negotiation
>    net/smc: introduce virtual ISM device support feature
>    net/smc: define a reserved CHID range for virtual ISM devices
>    net/smc: compatible with 128-bits extended GID of virtual ISM device
>    net/smc: support extended GID in SMC-D lgr netlink attribute
>    net/smc: disable SEID on non-s390 archs where virtual ISM may be used
>    net/smc: manage system EID in SMC stack instead of ISM driver
> 
>   drivers/s390/net/ism.h        |   7 -
>   drivers/s390/net/ism_drv.c    |  57 +++-----
>   include/linux/ism.h           |   1 -
>   include/net/smc.h             |  16 ++-
>   include/uapi/linux/smc.h      |   2 +
>   include/uapi/linux/smc_diag.h |   2 +
>   net/smc/af_smc.c              | 116 +++++++++------
>   net/smc/smc.h                 |  10 +-
>   net/smc/smc_clc.c             | 318 +++++++++++++++++++++++++-----------------
>   net/smc/smc_clc.h             |  58 ++++----
>   net/smc/smc_core.c            |  37 +++--
>   net/smc/smc_core.h            |  18 ++-
>   net/smc/smc_diag.c            |   9 +-
>   net/smc/smc_ism.c             |  50 +++++--
>   net/smc/smc_ism.h             |  30 +++-
>   net/smc/smc_pnet.c            |   4 +-
>   16 files changed, 445 insertions(+), 290 deletions(-)
> 

