Return-Path: <linux-s390+bounces-22011-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QjX4Ab6iUGrO2gIAu9opvQ
	(envelope-from <linux-s390+bounces-22011-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 09:43:58 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BD8738202
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 09:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=SmFAjgst;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22011-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22011-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A1193008D23
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BFE1E1024;
	Fri, 10 Jul 2026 07:43:53 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE423C76BD
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 07:43:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669433; cv=none; b=hECz6hASHNvE2olYK0IlwqUtpNkabLPPZVSB+fQemUyYGfnaYK94iL/k5LnmqVsqkAqWKtF5fkIcVN4UKklc8aVYKEFW/grdp/DvnFaRWLi93SIk2bw4hFvDrkwtEKb+QBGQvYurh8NHWsAcJwdMsLUXwqynqb2SCohSeWmfIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669433; c=relaxed/simple;
	bh=MF/S0hPtjh5rLRtp/1QPmNagCFg/g4Mzil71uf49GVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+6QLyaXsGVKcEVeE9Nc7bYD/oMiIQvTKykrjcz73NgXcJTd/YZn8lM8JeHMDsN84xtQqCMAfI1EJ3U9p12jLdw3MYgZ9Xi6EajB56D3jx2BNdWZqLppz9faaANsFFxIfcAEKQr6V6LagGC+amvAqwKnRbVP1zaS+ktonKy5UeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SmFAjgst; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3mhMl4125589
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 07:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VmNBIUXqLcxMVVxTjBW2PG8JJr5bsm
	28d+EaMpviPcc=; b=SmFAjgstBUHvXUEcV/IpvoPc0p7hQTq7r6/i3i5lb1ljJN
	OZpO6iZpd/kAEse3lD/ep7ojZF2sxUZW3czjnaRDtAm6nd1eZ7YEUveDOQqQ5Zqo
	3m1SQF+W4TORCgoBobGTLPVeFytsQOWwEQ1/YayW3kVC5w3R3klhbklzJUdPNvmN
	KZ0V7mjFFDxRbNSqxUuv+pBb8OXai7pwP1r+I1cDZKRQIYQwoRcfdJnUTsqe0w2Y
	z95X91E0XooFdyV69RqZAZK6Fn4c7ktqoCKsyqwczvEwQuR/Y9zgswPL9/Y6Qn74
	98Q8RqQhIykMK1l3Nue+uxL1DhC4z2K476sICntQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0av2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 07:43:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A7YZpl015966
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 07:43:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkgysu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 07:43:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A7hjUL58720600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 07:43:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D959620043;
	Fri, 10 Jul 2026 07:43:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90B7520040;
	Fri, 10 Jul 2026 07:43:45 +0000 (GMT)
Received: from osiris (unknown [9.87.146.126])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 07:43:45 +0000 (GMT)
Date: Fri, 10 Jul 2026 09:43:44 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390: Remove PIF_GUEST_FAULT and add PER trap flag
Message-ID: <20260710074344.17568Acd-hca@linux.ibm.com>
References: <20260709195500.1241833-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709195500.1241833-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a50a2b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=TUaCbrCJA9lGdIzC_NEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: figqaT1RTzlvHl0ryL6g2LvZ8CsY4DcL
X-Proofpoint-ORIG-GUID: figqaT1RTzlvHl0ryL6g2LvZ8CsY4DcL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2OSBTYWx0ZWRfX7Z1oDUPNgl0h
 A39D5ZIsqGcd3V4CnTsxZig+rPSGL8+Zmd0/0CLwfAL6xgmjhesrZ71T7Dnc2RHtZx/7P7LI7Rk
 iuvUuFnd2SrmKf6CjJImOymtEW80GFM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2OSBTYWx0ZWRfX4gauQ1ulIOvd
 vx6uTtEA3oNIk1R9lzU9An1pp7Ab2ntXaNcxYRM1lGfI/94lNUwSfFSMJAXoBhFPIVsYg9tDf5R
 X4B1diGe71gycsT/t+H4uPQ7nblnnGLUixgtGeaDuYfEjyrXo0uKItrviHu2kLER/L9kJ12qJu3
 ZJGLvfI4LBBDePxhqRDgH6nlNApubMPMDpGRAOcJk+Ljk12clnsjopVwEdIqobV7GI8Dmfbv5iC
 LO1DavJ6llzTZlzDI8wHI5SOTmdA5cDN7nRUYhaPrufpl2UlRJGTNGqlYhgQd30HmgH0+q51lfy
 BzwR1IrJBbQQXOxfoa13DJcyqgCfUMEqQ6IBehzokAxJjVlePqLTIlMzVWRqZvSsRgsEIh7fH/a
 64GN33YUicnYIep3Xv+tOy0ZgLYJvPA7/+Sc9xIHPf6GzVEFAMmMLRSxQ62WhjJjGElwvfo/TSI
 1UXedev6mKCVGmaSoeA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100069
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22011-lists,linux-s390=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:svens@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0BD8738202

On Thu, Jul 09, 2026 at 09:54:58PM +0200, Sven Schnelle wrote:
> While looking at the syscall code I noticed that entry.S still sets
> PIF_GUEST_FAULT in ptregs even though it's only used in __do_pgm_check().
> Remove that and pass it directly to __do_pgm_check(). Heiko suggested
> to also add a define for the per trap flag in system_call().
> 
> Sven Schnelle (2):
>   s390/traps: Remove PIF_GUEST_FAULT
>   s390/syscalls: Use define instead of '1' to indicate PER trap
> 
>  arch/s390/include/asm/ptrace.h |  4 +---
>  arch/s390/kernel/entry.S       |  9 +++++----
>  arch/s390/kernel/entry.h       | 10 ++++++++--
>  arch/s390/kernel/syscall.c     |  4 ++--
>  arch/s390/kernel/traps.c       |  4 ++--
>  5 files changed, 18 insertions(+), 13 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

