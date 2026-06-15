Return-Path: <linux-s390+bounces-20838-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vLDoMFfzL2qvJgUAu9opvQ
	(envelope-from <linux-s390+bounces-20838-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 14:43:03 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E468652C
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 14:43:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=lMs3ixBx;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20838-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20838-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C7C3300567D
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76913E832B;
	Mon, 15 Jun 2026 12:42:54 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ECD3E63A1;
	Mon, 15 Jun 2026 12:42:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527374; cv=none; b=TWzwp/UXwC25fXbfcQ+keFYq/jRp0sBSC1oKlR+MUGH24aWn5Gj4nuQDo9LD9x/89nWs7BVb9yrebWTQsNL0SZ3kaKD9fkA8nKDPhDu++JWxj2ztgreY/yKF0GE/AQcNqmi950HMIikloAaN9cQO6EQ9xZSshiIZqtvePFvHMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527374; c=relaxed/simple;
	bh=uGCWRcg7nkvCF9cmJmjyO6b2W5aX0FZKBrsVdMPrELA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XoumrdbNU5/Tsy22GwXBxfnwlb/8bpqZcw00IWROArNktXRon1ovLwUTFj615Wv/f8UDGbYl/CutEZSxkUYKFIjyag5eS5nW93vYo+0ZoQrgE8zY8U6PGbY3bz0kclhlj75dnlZzAIC0PkSXEgslITPM+9I7OYjYnkfVmvoQfNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lMs3ixBx; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAoBrM2209054;
	Mon, 15 Jun 2026 12:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9obSTjJ0egB3uAoQTsk16GuBIZw605sA8erwx2BpO
	OM=; b=lMs3ixBxP3Iaym/gWpTUiMx1XUntBeDuTSRMWAP8hNTU2suluuRBo0JBr
	BMtnr1X6WfbY9Veugb0+hafZAYcm1h7v0zU426BXb1T2/PNBhvz01qqP6QWWLOZA
	8FwoBprrGgXFG71JHXNMtu0OcC1yfNWtjW1cbrLuNl5O43CltIsc+DcZBtCX92Hg
	9TGfo8expMV9jwUbXo1Pkjh79xjwCkgkxeQWxaqMFBKDK5PWa/crPOMO3MqwH9uj
	dr4Yw1YhMrWwhT5mLqcAVd3Y7kLsUvd+im6H3ufa44zFJJ/feSN2g4TkGIPA72kW
	O1DaI5bxML2KkPLmXLOMXjgfM/ppw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm0g75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCYglY004883;
	Mon, 15 Jun 2026 12:42:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvxnsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:42:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCgh8I45089104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:42:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D875A20040;
	Mon, 15 Jun 2026 12:42:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 704B220043;
	Mon, 15 Jun 2026 12:42:43 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:42:43 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 00/17] KVM: s390: New features for 7.2
Date: Mon, 15 Jun 2026 14:42:26 +0200
Message-ID: <20260615124243.187614-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfX49arDwsD5uug
 E1wsQLSf9YCqkWKDHXJorIEWN2e8nqCANH7mHit9o+tbQT9t1ToTGuQ9XcnEKm/GNcF6bA+hqYP
 chbNJnt1/2QJpy3gdmXEF5QnbBE/Toc=
X-Proofpoint-GUID: 143TfodQBOwytgDWpjzdS3vJNC2japXt
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2ff34b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=ikCc7hGnDeZ8pAfFNToA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXwxc2tuRbtyu3
 3QXcdKjG2i/t+raZpF62SpGobr5IwdHEm/zIKyg4okUwb8iEHfCATgvAWB21coGDAjJ55JOqW9X
 g0yUj9NngGe2SluTSXs4OG8X97RqZxYHkP2N/3I/AFYp2jxTpD31Au0vgDI4UTV+VvjEh3zdP8p
 RwoL4jNVdw2JWh1m+iPoD2FYd7P5zXGg3oejtxwnF34jf12ToagxBKvXZxKKP2qnlLqQDK4vHW/
 ouq5M6WBh8NkBGyPhPwpIWJWoQWO8wOywPntucJmwYyD4Kp8Jvu+QtxeqoF7krccvx4XZKx9ddf
 41ZcepaUxKyxhUZO2J2kszYqqcqWMjo9wP780Ohn50+bFLYbzrfGgtFAgnLndC9qjkj/P64Thxo
 QGsrqwH6AxsIQoMZlTr8uS2gmg2QuxIMSF6AFoeDPSk2gWDFUzU8Au1UR8rToWMGXe43PP3Ge93
 p8SIowfYF+dDksfjQ2w==
X-Proofpoint-ORIG-GUID: 143TfodQBOwytgDWpjzdS3vJNC2japXt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-20838-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pbonzini@redhat.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:frankja@linux.ibm.com,m:borntraeger@de.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A6E468652C

Ciao Paolo,

Here are some new features for 7.2 for KVM/s390:
* KVM_PRE_FAULT_MEMORY support
* Support for 2G hugepages
* Support for the ASTFLEIE 2 facility
* kvm_arch_set_irq_inatomic Fast Inject
* Fix potential leak of uninitialized bytes


The following changes since commit 7fd2df204f342fc17d1a0bfcd474b24232fb0f32:

  Linux 7.1-rc2 (2026-05-03 14:21:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/kvm-s390-next-7.2-1

for you to fetch changes up to a868b30492c59f398359b7891293bbde8d126a51:

  KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject (2026-06-15 14:18:37 +0200)

----------------------------------------------------------------
KVM: s390: New features for 7.2

New features for 7.2 for KVM/s390:
* KVM_PRE_FAULT_MEMORY support
* Support for 2G hugepages
* Support for the ASTFLEIE 2 facility
* kvm_arch_set_irq_inatomic Fast Inject
* Fix potential leak of uninitialized bytes

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: Initialize KVM_S390_GET_CMMA_BITS memory

Claudio Imbrenda (9):
      KVM: s390: Track page size in struct guest_fault
      KVM: s390: Implement KVM_PRE_FAULT_MEMORY
      KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
      KVM: selftests: Fix pre_fault_memory_test to run on s390
      KVM: selftests: Enable pre_fault_memory_test for s390
      KVM: s390: Add module parameter to fence 2G hugepages
      KVM: s390: Add capability to support 2G hugepages
      KVM: s390: Allow for 2G hugepages
      KVM: s390: Document the KVM_CAP_S390_HPAGE_2G capability

Douglas Freimuth (3):
      KVM: s390: Add map/unmap ioctl and clean mappings post-guest
      KVM: s390: Enable adapter_indicators_set to use mapped pages
      KVM: s390: Introducing kvm_arch_set_irq_inatomic fast inject

Nina Schoetterl-Glausch (4):
      KVM: s390: Minor refactor of base/ext facility lists
      s390/sclp: Detect ASTFLEIE 2 facility
      KVM: s390: vsie: Refactor handle_stfle
      KVM: s390: vsie: Implement ASTFLEIE facility 2

 Documentation/virt/kvm/api.rst                     |  20 +-
 arch/s390/include/asm/kvm_host.h                   |  23 +-
 arch/s390/include/asm/sclp.h                       |   1 +
 arch/s390/include/uapi/asm/kvm.h                   |   1 +
 arch/s390/kvm/Kconfig                              |   1 +
 arch/s390/kvm/dat.h                                |   1 +
 arch/s390/kvm/gmap.c                               |  26 +-
 arch/s390/kvm/intercept.c                          |   5 +-
 arch/s390/kvm/interrupt.c                          | 559 ++++++++++++++++-----
 arch/s390/kvm/kvm-s390.c                           | 161 ++++--
 arch/s390/kvm/kvm-s390.h                           |   5 +-
 arch/s390/kvm/pv.c                                 |   5 +-
 arch/s390/kvm/vsie.c                               |  85 +++-
 drivers/s390/char/sclp_early.c                     |   4 +-
 include/uapi/linux/kvm.h                           |   1 +
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../testing/selftests/kvm/pre_fault_memory_test.c  |   7 +-
 17 files changed, 727 insertions(+), 179 deletions(-)

