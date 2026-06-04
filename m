Return-Path: <linux-s390+bounces-20522-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oLPsBtDRIWqiOwEAu9opvQ
	(envelope-from <linux-s390+bounces-20522-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 21:28:16 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA21A642DEB
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 21:28:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=gIOsnw3M;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20522-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20522-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2241F300380F
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 19:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B093A2544;
	Thu,  4 Jun 2026 19:28:12 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92589314D06;
	Thu,  4 Jun 2026 19:28:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601292; cv=none; b=gCdRXUXA0XxDswhOYxFvVlcW2BqbO9fDxSGuq+nbecr/FDg3/2qqlLIOiiDCWkiLuM3At6zWPDlaEJfAFmexX8JL/oJS7D/weT+1u8Kbzh5DQS+YwayyS7YbQ3swJnxTO7ep/7ax7BlYsRHXNC8xXYNGEUBlNee1scLwj3Rykhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601292; c=relaxed/simple;
	bh=O4iKPeNsTCDKVKQQIsfUBsm3fS/Y8Hytz4Yc4Dv6Xvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEvAMU1SOfcMOyRLtv/tqHHOScR/W5j3bPcDxm55EjoVr7B7Y5I0Pl7AHJTaUCQ6RgyvtRL7QLlmMdM6Ba/Hi+LoTJPHYGe53xnnUSEFEzUOvIaG/ttcgHzigneZLhpd5AGq9Ja3EcmpyilcY2EYNHakEeYTlYjBPRYJn8i6pHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gIOsnw3M; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654J8siX3013843;
	Thu, 4 Jun 2026 19:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yAHKaSPmaQvk+EJ/lOvSvusOYyKAIWDG2HyBfwsHQ
	W8=; b=gIOsnw3MXBq24eSVXnBEps6ReP49Y4fpW8BLoIjBSivxej/MSCHYzPCbP
	TtMNU3ov9iuFKeC/5lEFcyCKidBj5vynTdD4CiigZLyg1bHEPPFOfqfeCXdLLgsE
	p2zhQrZxQYlVi1g1fV8n6xR4E2x7Q1JMVzHpquUXCy+pSbaVfGRphH1JSSLlTCiM
	qPC1s6weF6OLQvk+SdlZF4WVhdPakY2dUcigzcVCFcS05QEOOirLrcd7OQvU4ch2
	HW6CqBfE/OP2yGRQi1RZ+U0vDJ1FzREJ2lajXqH4OJS5Jy8SiCAw04k+OeCwri1b
	pFy1DTVbvQeAJh5M8UXxEJJi61tLg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtgrv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 19:28:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654JO7eh006385;
	Thu, 4 Jun 2026 19:28:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegxb7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 19:28:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654JS1YF19530336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 19:28:01 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC03A58059;
	Thu,  4 Jun 2026 19:28:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D21FE58043;
	Thu,  4 Jun 2026 19:28:00 +0000 (GMT)
Received: from 9.60.13.83 (unknown [9.60.13.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 19:28:00 +0000 (GMT)
From: Douglas Freimuth <freimuth@linux.ibm.com>
To: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com, freimuth@linux.ibm.com
Subject: [PATCH v10 0/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic Fast Inject
Date: Thu,  4 Jun 2026 21:27:52 +0200
Message-ID: <20260604192755.203143-1-freimuth@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KsIOypyErfnPQWxkOYJcLYVpmbLVF_ZG
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a21d1c3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=84OqXecvdpAWjh0nY3QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE4NyBTYWx0ZWRfX4lINvfgRa+La
 7HYs7Cql6MsfsWN2dI7xrnWWkAfSFf1f/4oqCh21Bau6jnhD5xtjXPOqfx6cem2gp7dSaroCySj
 /yFxSNycOSu/pVlWSa2m7Z1foVxDIyqjux0PtcD4ruW9R608v5+Nmq1+euf4juvrNTnLtgVGIQq
 3lLREjQWddqUo8qLEinpnUdxSpUnVrcBFJkDM5kOwlRrOt1jl93wk8gkkXBLWRmLZQBJY3ytYY/
 niAabmJVsDi4/HYVkTwYoc8NL7d7uht7fOTArFzPVT1XSCbnjLDYFs/FN1fX2olnqqx48CIVoRj
 owJM9cmm6SxCupli66zy/Xqa7v1C93UWqaj12EHwPrsVkPPyx73JIsSxAof4saKvyeqxi/tRp+r
 61zo+DpJdTXcllVzDB6y6dRAZq/jSy/C2GZYiGTD3WBB5h4vAluGifsr7qfdm/Z4ONKWfIqlC4n
 FR+jpHYmKV8lsWYAsbg==
X-Proofpoint-ORIG-GUID: KsIOypyErfnPQWxkOYJcLYVpmbLVF_ZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-20522-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:borntraeger@linux.ibm.com,m:imbrenda@linux.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mjrosato@linux.ibm.com,m:freimuth@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[freimuth@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[freimuth@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA21A642DEB

s390 needs this series of three patches in order to enable a non-blocking
path for irqfd injection on s390 via kvm_arch_set_irq_inatomic(). Before
these changes, kvm_arch_set_irq_inatomic() would just return -EWOULDBLOCK
and place all interrupts on the global work queue, which must subsequently
be processed by a different thread. This series of patches implements an
s390 version of inatomic and is relevant to virtio-blk and virtio-net and
was tested against virtio-pci and virtio-ccw.

The inatomic fast path cannot lose control since it is running with
interrupts disabled. This meant making the following changes that exist on
the slow path today. First, the adapter_indicators page needs to be mapped
since it is accessed with interrupts disabled, so we added map/unmap
functions. Second, access to shared resources between the fast and slow
paths needed to be changed from mutex and semaphores to spin_lock's.
Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
but we had to implement the fast path with GFP_ATOMIC allocation. Each of
these enhancements were required to prevent blocking on the fast inject
path.

s390 doesn't support a PREEMPT_RT kernel and this patch doesn't either.
Given this fact, we are not using raw_spin_lock instead we are using
regular spin_lock.

Statistical counters have been added to enable analysis of irq injection on
the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
io_set_adapter_int and io_390_inatomic_no_inject. And
counters have been added to analyze map/unmap of the adapter_indicator
pages in non-Secure Execution environments and to track fencing of Fast
Inject in Secure Execution environments. In order to take advantage of this
kernel series with virtio-pci, a QEMU that includes the
's390x/pci: set kvm_msi_via_irqfd_allowed' fix is needed.  Additionally,
the guest xml needs a thread pool and threads explicitly assigned per disk
device using the common way of defining threads for disks.

Patch 1 enables map/unmap of adapter indicator pages but for Secure
Execution environments it avoids the long term mapping.

v9->v10: Streamline logic in register_io_adapter()

Douglas Freimuth (3):
  KVM: s390: Add map/unmap ioctl and clean mappings post-guest
  KVM: s390: Enable adapter_indicators_set to use mapped pages
  KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

 arch/s390/include/asm/kvm_host.h |  11 +-
 arch/s390/kvm/intercept.c        |   5 +-
 arch/s390/kvm/interrupt.c        | 559 ++++++++++++++++++++++++-------
 arch/s390/kvm/kvm-s390.c         |  30 +-
 arch/s390/kvm/kvm-s390.h         |   5 +-
 5 files changed, 488 insertions(+), 122 deletions(-)

-- 
2.54.0


