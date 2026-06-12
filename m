Return-Path: <linux-s390+bounces-20802-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QM8XNh8ILGrnJwQAu9opvQ
	(envelope-from <linux-s390+bounces-20802-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 15:22:39 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 493D7679BD2
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 15:22:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=nUfaAwnl;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20802-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20802-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F54633E50FA
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE023D3486;
	Fri, 12 Jun 2026 13:17:42 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4CF3ECBF1;
	Fri, 12 Jun 2026 13:17:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270262; cv=none; b=WMB4ikI3LeXmiyRw8tH0y1iFchR4s7y/J5vw2UI+/aOyAZZNKZNDEUsPa6rzdiOBFPzj7f1QBprVkWztKGYcaviwIurVXsvWT49Sm/3UyCUqzxfIJ5QFJTcxrl3pjBjNxhEai9DlhKTyqmKVdfiwtyQYyY8HEYcsRIxltWXqEqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270262; c=relaxed/simple;
	bh=PfYXBt0fBjT6MGzVL5VRFhrBwB/bw3V8yDlezPkQ3sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ToA16+vb0BHO78AXdHJBPyZ7X4CdZyxCYrZAHYXxzplqEqCMuB/0ecKwGVQgT1BNZ7XTuYm6fJCO4Ped3PTmOx5i7iampmnMEBAw2cnjSzbczYEzI51gVjkwtQyJGRghh+fYoe1iA1rn3aPel909x6qdvmA49lLtHCnsxXR1XTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nUfaAwnl; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BM03a91363883;
	Fri, 12 Jun 2026 13:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CBDkfU
	DeOtpCvaS0wYGy16Ta1axk4Yq0dcdcv2cI+6s=; b=nUfaAwnlQfCaN10C3vqPIN
	PitDA6ftOg0LOU+7s5if2wMMjsO9nEN98Qc6EikSOij29FwpajV+j53Udvlxx3aM
	SjFx5QecrnjCOWweGRXvsrax16OIYb/X4msd9TOSS1igKcTaP15W6vMLaPeXfLIg
	MyoWqQeHA1lNUYfKAsdTbm385VXuSfDuaSi+7FH4bBNMGktklHQAyIV9wbrZ//t6
	LNav0gFehAiBrS64DuUASW4I8R9LRillYtq1U7vxGOppuNvkJ30JacU6aK0D3beS
	lbQ5wPHMiXTED4JizFB1cfcrjYT18GE6at+jvN5mvplqWjRwwWWXtA4KzdVFdRQQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8e0quq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 13:17:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CD4kNt023111;
	Fri, 12 Jun 2026 13:17:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe08qysh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 13:17:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CDHZtS15466954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 13:17:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B614220043;
	Fri, 12 Jun 2026 13:17:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EAB320040;
	Fri, 12 Jun 2026 13:17:35 +0000 (GMT)
Received: from p-imbrenda (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 12 Jun 2026 13:17:35 +0000 (GMT)
Date: Fri, 12 Jun 2026 15:16:27 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christoph Schlameuss <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nina Schoetterl-Glausch
 <nsg@linux.ibm.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 0/4] KVM: s390: vsie: Implement ASTFLEIE facility 2
Message-ID: <20260612151627.6d2329d9@p-imbrenda>
In-Reply-To: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
References: <20260612-vsie-alter-stfle-fac-v4-0-74f0e1559929@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6tE4JVLYviPJihG8uqm8ZUI7EMOiDLJf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMCBTYWx0ZWRfXxJyYlnIZr4iM
 PGfXtbw87NFuPWLUWa/Xb/QwzGKwWNc9Tm4N247xRIjCqttvdX2s0U9l+2KbG5KdXeSnZZa1BpN
 aiq4zqe1BFYOF3HOCoEMXUKtWUT/o7HOiSdYLsvviPwtEcOBxgDbZR1iDTD+wj9+42mHlMTVQg9
 wof2YnB6HDY5lVCdi9429sXBkbu0YUSaIXlKz/+rhLFqWfM2Y6bnlIBNmQvwqyOW40pNMyYjP1m
 hDoBiKnf9SPJYsG8m585Q7kXCtLheTtY0WMPRzvJe3z+Gg11HboFOQsvBGIeTH0nvr8MsAEv+Kw
 rEETRouIBb1eOvagnu3+mxRb1Wx/UTPX9j2s2DrMh+dOrvTRDEyN1ATkt1n/+u9Rc+hvac9f7xk
 Tlc9ctjANkc0TgydTMyBuCXyt80uAZuNwGozMdtjHy2qXOCXugqEw7RaJClF/p612e/iaXJtq4D
 P7/QXtcID2Y51uz1Rew==
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a2c06f4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=haTtZzuiL25jbUqlTQoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMCBTYWx0ZWRfX5ffhhymhE8as
 mI9LAD3Goy68bTzMTUCYNOHKZ7lPrg3PemeP2aXbowRUvqC2FQ9Tx4f4T4ZNcH6wlLmClyi2uUY
 ekW7kRThKyrHjcLAI17kH7NnB/ygojI=
X-Proofpoint-ORIG-GUID: 6tE4JVLYviPJihG8uqm8ZUI7EMOiDLJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120120
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:schlameuss@linux.ibm.com,m:linux-s390@vger.kernel.org,m:borntraeger@linux.ibm.com,m:frankja@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:brueckner@linux.ibm.com,m:nsg@linux.ibm.com,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20802-lists,linux-s390=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,p-imbrenda:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 493D7679BD2

On Fri, 12 Jun 2026 14:23:00 +0200
Christoph Schlameuss <schlameuss@linux.ibm.com> wrote:

> Add support for STFLE format 2 in VSIE guests.
> 
> The change requires qemu support to set the ASTFLEIE2 feature bit.
> ASTFLEIE2 is available since IBM z16.
> To function G1 has to run this KVM code and G1 and G2 have to run QEMU
> 
> Tests are implemented in kvm-unit-tests and sent as a series to that
> list.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Series:
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

with one nit in patch 4

> ---
> The series was originally developed by Nina and only rebased and
> slightly adjusted by me. It was not sent earlier since the accompanying
> kvm-unit-tests and qemu changes were not ready.
> 
> ---
> Changes in v4:
> - adjusted struct kvm_s390_flcb2 to make sure reserved0 is always 0
> 
> Changes in v3:
> - renamed struct kvm_s390_f2_flcb to kvm_s390_flcb2 as requested by
>   Janosch
> - rebased
> 
> Changes in v2:
> - adjusted variable naming in handle_stfle()
> - add some constants for readability
> - add struct for format-2 facility list control block
> - rebased to v7.0-rc1
> 
> ---
> Nina Schoetterl-Glausch (4):
>       KVM: s390: Minor refactor of base/ext facility lists
>       s390/sclp: Detect ASTFLEIE 2 facility
>       KVM: s390: vsie: Refactor handle_stfle
>       KVM: s390: vsie: Implement ASTFLEIE facility 2
> 
>  arch/s390/include/asm/kvm_host.h | 12 ++++++
>  arch/s390/include/asm/sclp.h     |  1 +
>  arch/s390/include/uapi/asm/kvm.h |  1 +
>  arch/s390/kvm/kvm-s390.c         | 46 ++++++++++------------
>  arch/s390/kvm/vsie.c             | 85 +++++++++++++++++++++++++++++++---------
>  drivers/s390/char/sclp_early.c   |  4 +-
>  6 files changed, 104 insertions(+), 45 deletions(-)
> ---
> base-commit: 0e5d0a0b5ca6ea4e391d6786266405c5871e0151
> change-id: 20260129-vsie-alter-stfle-fac-b3d28b948146
> 
> Best regards,


