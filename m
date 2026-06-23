Return-Path: <linux-s390+bounces-21180-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jK9zNn+yOmrFEAgAu9opvQ
	(envelope-from <linux-s390+bounces-21180-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 18:21:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D836B8AFA
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 18:21:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=b0bEQ7Zs;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21180-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21180-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2B03300A775
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2026 16:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE930E0EE;
	Tue, 23 Jun 2026 16:19:13 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343F30DD2A;
	Tue, 23 Jun 2026 16:19:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231553; cv=none; b=roYYHSAFl8bnY1GcX4KW5FFyVZXOcECOZbs+PvZvC2fupgOKR6pqMgYOsu6fRyg9Vyu6bC+BzJTjdMA5pXZltJKcj3nkYuBHPNkQ3w4SJkpGeCn2C20G+BuHcPMvpjKYL/CQDhWbW3Dw6SY/b0BgUNZgLdHelT9rt9O4d5+8s0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231553; c=relaxed/simple;
	bh=PPO6wIb+Bt+dMT/UWZ/ynlIKN1ol1dou/GKcpH59m5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLVyDUf/+v/NElj0sdcD6KoZ2kvbbu0MbI+CHvadxE6AOw+S0jDzsSXuxMEweTU8pVqMKQH7EE4zSgJKAI766aSVgtXnfOeeKKnpJq0IyVNhMSozC7S2CGuKdHUHq4vdFizQ5Z0YSHfUm6VoXERtx7XZX7nxViSZNJb3SENGCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b0bEQ7Zs; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBn4Fg1827221;
	Tue, 23 Jun 2026 16:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TzOh1u
	ScHS0tnNDnBZfWjsEO7KWP/WnnDVWPjiDTAhU=; b=b0bEQ7Zs9tSdf+IFyeSGcE
	CchZ75pHw1TOUGtm8I8iKa0MWTAwK8g1GIcoHt/9tYP1qRTm57EE4SqsPHr/ozpV
	7Pm1dmuG1PZcqVsXpUAkY5+WdqqdHwXSylAlSlFn4mMckMM3PeCnZCYGpDn9zFVq
	6AbKiueqOBbU/pmDJD16PYlpH/iyM4tCtGT9zYBoPGBC0wbmqYSzqvnCgJc0HHHW
	agNCxt8ZA2DrEc4hNt0Z4KNPMwC3EJ8d0uYgcldfjHbo+yXhlbvfWvqh/jMw2LHS
	c1Csfu+SsABnOrTKaxHyWkRsVbw6eRhMBnPY3ULpRDIHXdoy/jQO8lG1dACDmyWw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsqf1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 16:19:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NG4ded000546;
	Tue, 23 Jun 2026 16:19:07 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykw6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 16:19:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NGJ6ud29229652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 16:19:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 180D658055;
	Tue, 23 Jun 2026 16:19:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EBFB5804B;
	Tue, 23 Jun 2026 16:19:05 +0000 (GMT)
Received: from [9.61.246.142] (unknown [9.61.246.142])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 16:19:05 +0000 (GMT)
Message-ID: <a2dcd383-e93b-4771-916d-d836df5f48c2@linux.ibm.com>
Date: Tue, 23 Jun 2026 09:19:03 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 0/3] [VFIO] Error recovery for vfio-pci devices on
 s390x
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
References: <20260615183616.2902-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260615183616.2902-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEzNCBTYWx0ZWRfX64mAl/hglsfK
 RfiSX70vdsWdNw33AVd3H5lIl2HlSa6R1ae0HXCpLkCKKbbxFrr2XsZJ6cTCNxJ3hE4Sul22sXF
 1JpG9yFTUJocwmxZsaMBsfncgU0IpQmqwTWUg2jI7nq6ci/zjf1BmNF/SigzIreYubU3I5PtOJp
 nHNC3EuvC7KbzHtB3cjohtPGvQi8QMOXlxa/l4IuUAbDwS52wFmJoZol4J9j8y4kXjEmFLev1Wl
 jjq9bw5P3jKSPbPStbX6c9KYRbsvMaJSFuh35TqUd0wQMgkmiCFeR7PgP5P14GyBwZC6L02qrVv
 nHRnUaNv3XgYq8RKhWEbVPPiZdNORnOTwBuJWxRuXArsdixWv5+yEESg2sjrOeB3DmDyQmTtU8s
 yHNjFai8zomHVBoXU4vM47ZwouzRuXVwVH1YsUOdaPldkgvikQZhgIIz5lwPv/TpTTzJ9GjKlvt
 emWJu4kWWLXeC099dnQ==
X-Proofpoint-GUID: eD8aR15YGrWQ69KnL83WWl6BDQVSFotQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEzNCBTYWx0ZWRfX0tFG60/NzE5R
 pvNEVKAyIDx2Ln6rAdvYsDY44oHgmkJTItAOvii/mAS7h0X3Z/ajk7CIWW89/bxBHzR1eh4wPox
 OG21mxFUw/t5iNx4fIuuDWoKhr0q4eU=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3ab1fc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8 a=29iEHxvmWTY-H69hz_cA:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-ORIG-GUID: eD8aR15YGrWQ69KnL83WWl6BDQVSFotQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230134
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:alex@shazbot.org,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21180-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30D836B8AFA

Polite ping for this series :)

Thanks

Farhan

On 6/15/2026 11:36 AM, Farhan Ali wrote:
> Hi Alex,
>
> This patch set includes only the VFIO patches of the original series for
> error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
> series into PCI and VFIO only patches to make merging easier based on our
> discussion [2].
>
> Thanks
> Farhan
>
> [1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
> [2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/
>
> ChangeLog
> ---------
> v18 https://lore.kernel.org/all/20260603182415.2324-1-alifm@linux.ibm.com/
> v18 -> v19
>   - Fix hole in struct vfio_device_feature_zpci_err.
>   - Remove reset_done() callback for vfio-pci driver.
>   - Rebase on 7.1-rc7
>
> v17 -> v18
>   - Print a warn with dev_warn_ratelimited() for copy_to_user failure.
>   - Rebase on 7.1-rc6.
>   - Break patch series into VFIO patch set.
>
> Farhan Ali (3):
>    s390/pci: Store PCI error information for passthrough devices
>    vfio-pci/zdev: Add a device feature for error information
>    vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
>
>   arch/s390/include/asm/pci.h       |  32 +++++++
>   arch/s390/pci/pci.c               |   1 +
>   arch/s390/pci/pci_event.c         | 137 +++++++++++++++++++-----------
>   drivers/vfio/pci/vfio_pci_core.c  |  10 +--
>   drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
>   drivers/vfio/pci/vfio_pci_priv.h  |   9 ++
>   drivers/vfio/pci/vfio_pci_zdev.c  |  61 ++++++++++++-
>   include/uapi/linux/vfio.h         |  30 +++++++
>   8 files changed, 221 insertions(+), 62 deletions(-)
>

