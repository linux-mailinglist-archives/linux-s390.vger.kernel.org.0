Return-Path: <linux-s390+bounces-20106-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMzwAEMDF2qz0wcAu9opvQ
	(envelope-from <linux-s390+bounces-20106-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2026 16:44:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78795E61DC
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2026 16:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD50530013AD
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2026 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D39421EFB;
	Wed, 27 May 2026 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nRQ7fqdr"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FEF3C9895;
	Wed, 27 May 2026 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893052; cv=none; b=mf0qBrIuOeTqi66jh1ecHll7nRyXchLjU8S7+pKrlLOcV+HnHAET2dpMZJDlCpkgnaEyM0LutS3aXiuWHYU1kPQda39Htk6dZS6fKqxLyKjaGPhRKWW9/GNpkQ92GOhso2pF6GCHoACcCUPqLDvIFiv46Zafl89mbNy/3zKe0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893052; c=relaxed/simple;
	bh=FjQeccB0HfpFZYyuynKTH5RgFHk9XbIVNvs05kM9s+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF7F2tF9bQFglrxGOefV26nKNTaNNam7piXnpDyhf7K1lKf4SEfSx2AGV02NrReIwG2XKf+nLVJo42rD4yvlYNCE4GrAJuAzkepjNsa+5yGLj71o+LI0e0GfXq1y86t5rv85eKlo4u7nDyzMPLxuu5Ha65bkO+flsFr+vJmcz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nRQ7fqdr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RCnZtf3594654;
	Wed, 27 May 2026 14:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nbd3iHoUzlIuxdqJ4
	GyJKHMfXggrDxgF67BeU0h1BoM=; b=nRQ7fqdrF42AuOtv84BStRNo3sNmoH4gh
	KZsucrGZYX/3Po1YppxxdjSqwiVK68c6UwhuXrapbld3tYuB5vIeTO68uTNAkTlU
	7ENM+6gZUkAErDOUcV6xLv46wkBbdXueYya19LNWW2FHpapW2OlENobvgUvQn/O/
	AHb3QZB2hWJjkvVmPvZD4gyp92BmAf1AHFIeZaw3VOPtaiP8kuwMUjKN2yMX0rXQ
	8EASas6dcQSimNzT7H9BoUdeQGXGK7pBGtcrxYkpA3tKObyzWr20QmGvJWCNKWgm
	h2jDAqTVrI8nxZkKcL6tQ2iapGoBShbKLs6KD4c37Gu613+ykiWOg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2huy0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64REd4lc000618;
	Wed, 27 May 2026 14:44:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb3f4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 14:44:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64REhxs930998878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 14:43:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E8B420040;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39E2A2004B;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 14:43:59 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        pbonzini@redhat.com, seanjc@google.com, yan.y.zhao@intel.com,
        isaku.yamahata@intel.com
Subject: [PATCH v3 3/5] KVM: s390: Update KVM_PRE_FAULT_MEMORY API documentation
Date: Wed, 27 May 2026 16:43:56 +0200
Message-ID: <20260527144358.186359-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527144358.186359-1-imbrenda@linux.ibm.com>
References: <20260527144358.186359-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: NCVg82Jk9nAQtoutbhZAX1I_bhDM2z2Y
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a170336 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=p5bRbc-Dsex6zWGIe5sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE0NCBTYWx0ZWRfX1dh4CkdlEJ0J
 je4W3opcIqb6SJSEhx6Yerf6PI0Yc0do49pik7bsB5lhg7weW4xEkC6p0v9M65XtG/+V23Tsmqd
 j4k//I29WpbHWep5SpD33Jp1AKbtGCUVmavwwG6dgVZOmR9jjR2OBcKuxPXV2RTSXkbL42Az6qF
 Sfuj4EGb404XMPShZiFBiqrMzcBh+gRDUlJukdPyCEb6xTog7qqtM8+n42hmZDozqsENG5rFkXH
 0fYFSKBxoq27va1qu/n+mKG4Y0+N6U9nAwuCAf4cenYCad4oNTpK7+5qhT789ynfd5wLrTkrVcU
 cIgMCiLsMgif0ngeIJKObGLYgPnPA3/EWIxSiEa07q6G7G/72RLlLBR/2WRNj+AcuBm4iSfjU9O
 jWTB0KXYXdwPjgy6BsCvHjB1F7Gnw6tfOMWwaonCDwQBdxIpQTMtjgw+x3rHUen86elxKnveJBg
 EQZI8z5HWRNk+jMMVcQ==
X-Proofpoint-ORIG-GUID: 5WOffRqmJlE3cHcCVOk_6Wm3DJlAJili
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270144
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20106-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.ibm.com:mid];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D78795E61DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the API documentation for KVM_PRE_FAULT_MEMORY to account for
its s390 implementation.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..e7998feaa940 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6471,7 +6471,8 @@ Errors:
 
   ========== ===============================================================
   EINVAL     The specified `gpa` and `size` were invalid (e.g. not
-             page aligned, causes an overflow, or size is zero).
+             page aligned, causes an overflow, or size is zero), or the VM
+             is UCONTROL (s390).
   ENOENT     The specified `gpa` is outside defined memslots.
   EINTR      An unmasked signal is pending and no page was processed.
   EFAULT     The parameter address was invalid.
@@ -6494,7 +6495,7 @@ Errors:
 KVM_PRE_FAULT_MEMORY populates KVM's stage-2 page tables used to map memory
 for the current vCPU state.  KVM maps memory as if the vCPU generated a
 stage-2 read page fault, e.g. faults in memory as needed, but doesn't break
-CoW.  However, KVM does not mark any newly created stage-2 PTE as Accessed.
+CoW.  On x86, KVM does not mark any newly created stage-2 PTE as Accessed.
 
 In the case of confidential VM types where there is an initial set up of
 private guest memory before the guest is 'finalized'/measured, this ioctl
-- 
2.54.0


