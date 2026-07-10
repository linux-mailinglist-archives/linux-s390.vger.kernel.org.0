Return-Path: <linux-s390+bounces-22020-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mUsPMYG4UGoC4AIAu9opvQ
	(envelope-from <linux-s390+bounces-22020-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 11:16:49 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1611E738F04
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 11:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=evyLDqua;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22020-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-22020-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60F4630115B7
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7F13DA5DA;
	Fri, 10 Jul 2026 08:55:16 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFA33D9024;
	Fri, 10 Jul 2026 08:55:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673716; cv=none; b=eeSGpxXunpYGcZKkFwT8ek0GU4TJwFW61kXWhEPAdFAm0Bfp7Oq0gdxOO7iLKlaQHYCjVAW90jlIb4U75IN/hqIDayEucqWGDWvlv9Gujv8XnXiEF7fMwXUdwLoti67lwlHQ0EjZNU31L4+g1zWF5HvSWChfko4Jnze8d7wgLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673716; c=relaxed/simple;
	bh=im0MWpiIh7M6OR8CRP5a/qSQGEmTtNGNI0QhiTxgcII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVtIsiZoq4x3Pu/oXmoT/Q5WRLLem8RFDsvdn9MbRndD2Glq6k3dSLS2EvLuqe2+k1G4I5l5yyo1r9NbRpOTrzGJBJjxDXNsCMF2IiQat7HW/fME5YUFIUXGeo7uHk29P//79PlBqx7wyPIuiALDGx09o6lFB2ZmLVBkNyGF6vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=evyLDqua; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7masZ605539;
	Fri, 10 Jul 2026 08:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PT5zAyfYZGqrjZ4d9dNVpiOgJ/2Bhf
	KmMzH9KYHUPCs=; b=evyLDquaWgbDutRXRl7/XsG6iNMUnmOMIZN5YrvXlwKrYN
	CDJCH8PwqntSSmkeWWiSY5NA6rSpT2vFaVzwIfLyecRZQdMuEpUgZY0+UqkJg0mZ
	6NUmTjfNgWR1LaxOM+AguEmQ7bXFFJcN4J52fLGs11NS3XmHnsoP2fmeZRX4/PBZ
	QCmFpL+5s0s2Zg8DGg86RPRbNSC7KZUVNpgbnOZp1UpG0ATQTPVkojg7Gjv5wFnB
	CUFtVGuHSEKUAS9j+Vd+dlhZfIS3VLPzaPhjsMvXUmrCetkPorj/bhnfpK91ef4X
	W2zp/g1/6RHhQOCCii4+cVEN0ZGiRfFbQLsTaL7w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknw70r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:54:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A8ngsj025443;
	Fri, 10 Jul 2026 08:54:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ygvjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 08:54:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A8sink12321080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 08:54:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB6FD20040;
	Fri, 10 Jul 2026 08:54:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08E822004D;
	Fri, 10 Jul 2026 08:54:44 +0000 (GMT)
Received: from osiris (unknown [9.87.147.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 08:54:43 +0000 (GMT)
Date: Fri, 10 Jul 2026 10:54:42 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
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
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 05/27] KVM: Remove KVM_MMIO as config option
Message-ID: <20260710085442.984749-E-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-6-seiden@linux.ibm.com>
 <87a4s37scc.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4s37scc.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a50b35c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=9pq-tb42-J4kxd0kViUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: wM388sXXjnjG4_TIOd2ildNFbThmqmSd
X-Proofpoint-ORIG-GUID: wM388sXXjnjG4_TIOd2ildNFbThmqmSd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA4NSBTYWx0ZWRfXxGXLvy3r34pv
 2y3rXeOF17UYrpTG1ZMCkfV+BaHFzFD97Qu+UJoguBttolXd/3SdBkI3dtFYW1gi9hsAr/6b+Ou
 6ppDN13fVX0ETlOUQQlHey/Isj23Jk0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA4NSBTYWx0ZWRfX3CFc8mLUo+4u
 CIYnQElsV3jjWye2hGYjlrMeeLPTvVgLyjSb7KwYSsEc4mE5GvP28T0ObIxEPQ90bOpDcnNvJox
 IvT2tGBZQiqPu90wCVjhGTpTE0oxdZML6bcTbd1Png+6TvbUuVJRJXc6fBghjx3xRlDIY+N6ajE
 0pS6iPYow7kzyjq7FaCZ87RO6zAMaq5duZgDd20bBNyGmLZKSj89yzsKWjwYXSnnDtBeprqQlAe
 wFDQDDWEYaw1U/aPxtjVjQMK91Kq0Esiy9UqBBFJh8GvhFArW++x6nsyEHpkulsaGtpYfhv/9JE
 WYY5baWDCUYDpnOtjZDD+InFgnkteq2kVj9DMnWP3KDJf6mp4wB0GwK2OXg/lSgjfcxpqw5DRLp
 EedaSKfiOVE/jEzH9Z5oU9y5YtCDRRF15Em/72dmPHFEnZpt8tAThxGrBU+tIr9lXMqc/Rd52B3
 J0XD42UBOQrx8e4SWlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100085
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-22020-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:maz@kernel.org,m:kvm@vger.kernel.org,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gra@linux.ibm.com,m:arnd@arndb.de,m:catalin.marinas@arm.com,m:borntraeger@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:fritz@linux.ibm.com,m:ggala@linux.ibm.com,m:hari55@linux.ibm.com,m:hca@linux.ibm.com,m:brueckner@linux.ibm.com,m:iii@linux.ibm.com,m:frankja@linux.ibm.com,m:joey.gouly@arm.com,m:nrb@linux.ibm.com,m:oss@nina.schoetterlglausch.eu,m:oupton@kernel.org,m:pbonzini@redhat.com,m:suzuki.poulose@arm.com,m:svens@linux.ibm.com,m:Ulrich.Weigand@de.ibm.com,m:gor@linux.ibm.com,m:will@kernel.org,m:yuzenghui@huawei.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[seiden@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seiden@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1611E738F04

On Mon, Jul 06, 2026 at 09:53:23PM +0100, Marc Zyngier wrote:
> On Mon, 06 Jul 2026 09:52:05 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Defining KVM_MMIO is not flexible enough for multi-KVM systems with
> > different Kconfig options regarding KVM_MMIO. Therefore, remove KVM_MMIO
> > from the config space and use the macro HAVE_KVM_MMIO instead.
> >
> 
> Given that there is only one KVM architecture that doesn't use
> KVM_MMIO, it feels like the polarity of this symbol is the wrong way
> around.
> 
> Something like KVM_NO_MMIO, only exposed by S390 for its native
> support, should significantly reduce the churn.

Makes sense. I'll add KVM_NO_MMIO and conitionally compile based on the
config and not havng this symbol

	Steffen

