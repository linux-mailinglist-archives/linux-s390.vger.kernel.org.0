Return-Path: <linux-s390+bounces-20583-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P8BSKHJ7Jmq9XAIAu9opvQ
	(envelope-from <linux-s390+bounces-20583-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 10:21:06 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D827653F4D
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 10:21:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=dBhyBufm;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20583-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20583-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DC267307C26F
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2026 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C9399351;
	Mon,  8 Jun 2026 08:10:52 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35E399372;
	Mon,  8 Jun 2026 08:10:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906252; cv=none; b=AUk/dIoTb2M5E9c6LxTd+m8SelMdTSjCCjY57kifHsK0KjqU/WoyqaA2YIfy4HV5AWLAxz64BX49INn4de9go1gN5WSJ8sm6adhst3XAPZ+cJ1kPTTBZRQvm/VZE5WKMFfzUAgAZITvfw5PkTpnad4NO+T4WgwwJu92sqkOQdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906252; c=relaxed/simple;
	bh=PuW+2DQ9oqE9O+a/yBjXCO94jYHzNrX7BI8SzQ1G7os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK4eNtNn3PojBx9cQnrNp4fWF7LgaZh3PQlsMsRl+Jm0+vv2polaJjSqTVRT5uD/y8YulmaGx61batc4YvfQA/8bh3LYJKrDV2QEhWcQ63E+M7202Ba8E7/aJJln/feDlY/z91Ijt39CO1scsC90+aHDrEECeOM/wFNIzVp8tEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dBhyBufm; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6579b1fu2990707;
	Mon, 8 Jun 2026 08:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ybZQjal46FeOrn2hm6lTCaz+t/9Rl0
	Db41fcp16G+Dg=; b=dBhyBufmfP4wvnfQ9Irzgd66IC9FtHX38d6Tu1bbxef+5D
	0zrk4mJoy93bWMF4jAi5szsjPx9Tw/dzN7SGBbodJGrGOqRuuK8F84HlhzE2TyZi
	mNUreGXVwOTCKQ0MBgGCTwM7lYoMjpWNi62HZ/MOKD34ZsLQ8YfyWNXNt1NStGko
	UDG3fuO7F/oCayF7r/a4ntffPKO+ByTOyV3ownyCK3wZPJOEFhQtJGcD5OCtAxsm
	CMSQeEW0+nlXK0XB7wiogaJIYF/YMDvNMwfcSVj9eLLutsaPf2MiNgLqeabF/Wke
	mikzD0yQUw13FncQ6E/KoY8Ke+RhapWMmlhDBZzg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhpf9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:09:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65884ZXK014601;
	Mon, 8 Jun 2026 08:09:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fv82v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 08:09:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65889pCN55968026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 08:09:51 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6EF920043;
	Mon,  8 Jun 2026 08:09:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2336620040;
	Mon,  8 Jun 2026 08:09:50 +0000 (GMT)
Received: from osiris (unknown [9.87.136.35])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  8 Jun 2026 08:09:50 +0000 (GMT)
Date: Mon, 8 Jun 2026 10:09:48 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 12/26] KVM: arm64: Add PVM_ prefix to avoid name
 collisions
Message-ID: <20260608080948.100035-A-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-13-seiden@linux.ibm.com>
 <ah4GaFNM7xfS7CJC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah4GaFNM7xfS7CJC@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NCBTYWx0ZWRfXyCkHnN7Bi5ra
 BiLvAZzGqCaTUYlhd3Fu2wWFJ9R9s01M7j5kvTtiiXgAzuKU25KIjGu/i7RLgMErYk3Yn9t5okg
 oJxFxM9tZARCVdPpr7liIYYsfyLRnLjy8uuNen+Huw0vxnYjQulU0I8aTW9NwWZJBx2fD1jhvKB
 4GFLIrU2JmKmNrNA3KED9vSxCpVgdp3ct1nmcbMvOvpiMtUm2bDdujf4+e3OCVFpGo3fHvYgDZb
 qUr3+FWmcKKVISox41jOdQznLMMHuc+spBKWUsDra7nyaDWxixcMOYd6lxga/AgRwa6BlV8d32s
 1WfJDcNVFuo2gAHDjJ57La9sVXR0dNmatppsAyTb/UkgVgouggJ2i1jdzwNCwkjTwbhc3YGzNv+
 ky2AqTU5puiuEGrdKe8qbYbgLZOUuijjX/x/rA6u/DNBHv2WYzD3fPoJSgbU9vBQyCQfvz13MFL
 i8DwoVYtC6nBJM3B2OA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a2678d6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=sjSFLaudIdQReGWt298A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: 0fCevorcLqPyPvXErUXpRrKCxITKL_ji
X-Proofpoint-GUID: 0fCevorcLqPyPvXErUXpRrKCxITKL_ji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20583-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[seiden@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_RECIPIENTS(0.00)[m:oupton@kernel.org,m:kvm@vger.kernel.org,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gra@linux.ibm.com,m:arnd@arndb.de,m:catalin.marinas@arm.com,m:borntraeger@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:fritz@linux.ibm.com,m:ggala@linux.ibm.com,m:hari55@linux.ibm.com,m:hca@linux.ibm.com,m:brueckner@linux.ibm.com,m:iii@linux.ibm.com,m:frankja@linux.ibm.com,m:joey.gouly@arm.com,m:maz@kernel.org,m:nrb@linux.ibm.com,m:oss@nina.schoetterlglausch.eu,m:pbonzini@redhat.com,m:suzuki.poulose@arm.com,m:svens@linux.ibm.com,m:Ulrich.Weigand@de.ibm.com,m:gor@linux.ibm.com,m:will@kernel.org,m:yuzenghui@huawei.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seiden@linux.ibm.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D827653F4D

On Mon, Jun 01, 2026 at 03:23:36PM -0700, Oliver Upton wrote:
> On Fri, May 29, 2026 at 05:55:45PM +0200, Steffen Eiden wrote:
> > Rename ID_UNALLOCATED to PVM_ID_UNALLOCATED and read_id_reg to
> > pvm_read_id_reg to prevent future name collisions with other subsystems.
> > While at it, fix whitespace issues in the macro invocations
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> 
> No issues with the rename but do you even need the nVHE object at all
> for s390?

No we do not need those definitions. The problem comes with a later patch.
The ID_UNALLOCATED macro moves to include/kvm/arm64/sys_regs.h. Then
arch/arm64/kvm/hyp/nvhe/sys_regs.c redefines that macro.

I renamed the function to stay consistent. 

	Steffen

