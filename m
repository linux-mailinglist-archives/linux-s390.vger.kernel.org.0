Return-Path: <linux-s390+bounces-17555-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCK1D++zumlWawIAu9opvQ
	(envelope-from <linux-s390+bounces-17555-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 18 Mar 2026 15:17:19 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 988BC2BCE40
	for <lists+linux-s390@lfdr.de>; Wed, 18 Mar 2026 15:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67D4F3029E5E
	for <lists+linux-s390@lfdr.de>; Wed, 18 Mar 2026 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648B3DA5AB;
	Wed, 18 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jCEhx0rz"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8983D647C;
	Wed, 18 Mar 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842943; cv=none; b=RF4CfLuMdNyymyWzY+e10CmVUE32WNLZ16sf4lMWWDKSf/Do4n9MPmY93A5Ax8j7xh5neQhzycbdRlet3NNPVCn/n9yJLYsALmzex/4tchXMBW0BnNYktSyOudn/BY9zwV+bHMhfddXF9iB/cqhHBoB9eEsQmP023nof7DVMgME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842943; c=relaxed/simple;
	bh=p6IZK6RY/a5+hZ2XNJs57bZt9k/i3uuq0iOaIgRCtOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VFfzmEdBYyji1HlEplbOWmhYIKW5TNAf6lVwTLMo4tlbUluwaQX1wZ/RvxTZE2Yaulk23SJzmrpdzKj8eELbP1myXeDHwKADPeG54knHC0V3JrPqVaEVUlkdvlw380PR2rrQyBnt/W2vfVj4YcJnGBcLmgI214ZtXehy0pmw8m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jCEhx0rz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I6r4TS920790;
	Wed, 18 Mar 2026 14:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4jjkLz71xefWb+irS0GGPlaBl4wXT0ntCscxnfANB
	LI=; b=jCEhx0rzA9i+k/tCNqGm23XS3yS3OlOsrtgRIHBbOvS26x+0gZuBjJbvL
	5WFWWJbXoEGUufPYpCKnvJgOh5nmJgTbFv/rIoxcELt6S5QkEISql3H86nEVGyf4
	9je2b3W+E5D7iT5iL2lCNGG9qrgfNder9q1MlPp+ywxZydJfpyv8fFvCW1Tzl9tT
	MlrKmCvewJFc9FbCpHDsv2Bn9e2aD5hWH8FPasNhrUcyuPNBHwiakWsYV1OuhCml
	4DZLoyfLWPxlYwFQSs7LY3f1gLNg/bghB0+zpdAQM7e+NtOlQaTnF5pJvxZ9FGZQ
	84oKDKszaKT9iNqoavv7sI6MZoxZQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3d1q0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62IAsH6S028501;
	Wed, 18 Mar 2026 14:08:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1e2wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 14:08:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62IE8sHV57541056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 14:08:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36E572004B;
	Wed, 18 Mar 2026 14:08:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E968A20043;
	Wed, 18 Mar 2026 14:08:53 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 14:08:53 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nsg@linux.ibm.com,
        nrb@linux.ibm.com, seiden@linux.ibm.com, gra@linux.ibm.com,
        schlameuss@linux.ibm.com, hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v1 0/7] KVM: s390: More memory management fixes
Date: Wed, 18 Mar 2026 15:08:46 +0100
Message-ID: <20260318140853.119460-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bab1fa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1sD2G6HcTPzl9Np1URUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfXyVPbsERHeHwc
 2sCNkNUR9vCAEgZstTf6EOQgSs2b8rMDdvCcJVaSJbRYznSPjqH+l3UJBh1eLxkdyXF13WaAvvN
 sCGzkoFeSmdudH6tzvAmfAZK4vPN4I9sFe53v5JjooscFKXqLro5jSKPaMoI8n2XamHB+gxni0H
 +n4eQJvVQO31Vs3v1JZk7cnppg0AIAnLxPd0NPoxsaIzKVwDrfMBpN+BTKIKMYm+awFM3ciuyMU
 zsBSTyplsJ41Knx/QFjo9q/XQPbaB+pNWHxoQb3FOkfbDtbEnx6KY/qZdw8XXK5adS0sm5J2S9X
 B9VIgLlhm9AhQqZfgc3eWmRe2Cxf+zL/pe2KlGGamX71RBSQCJ5TLGJPU8c48n/RrAq286QIpg5
 PgUJoPsDT+6DRV692FTDk0hzrSkWM8UvD2MiYb8mVOzjBxGytnChJVq+Hiu4gM/5iCmxLkkdxRp
 VLuzMXUYT0KrKSPRBMg==
X-Proofpoint-GUID: iyCB5tqMbxIR2AzzXyRTj4CROGMmXx_D
X-Proofpoint-ORIG-GUID: iyCB5tqMbxIR2AzzXyRTj4CROGMmXx_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180116
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17555-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 988BC2BCE40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes some bugs that have been recently introduced with the
big gmap rewrite.

Most of the fixes are related to vSIE (nested guests), although some
are more general. The last patch fixes an issue introduced last year.

Claudio Imbrenda (7):
  KVM: s390: Remove non-atomic dat_crstep_xchg()
  KVM: s390: vsie: Fix check for pre-existing shadow mapping
  KVM: s390: Fix gmap_link()
  KVM: s390: vsie: Fix refcount overflow for shadow gmaps
  KVM: s390: vsie: Fix unshadowing while shadowing
  KVM: s390: vsie: Fix off-by-one when protecting guest page tables
  KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl

 arch/s390/kvm/dat.c      | 101 ++++++---------------------------------
 arch/s390/kvm/dat.h      |  11 +++--
 arch/s390/kvm/gaccess.c  |  13 +++--
 arch/s390/kvm/gmap.c     |  98 ++++++++++++++++++++++++++++++-------
 arch/s390/kvm/gmap.h     |  32 +++++++------
 arch/s390/kvm/kvm-s390.c |  18 +++++--
 arch/s390/kvm/vsie.c     |   4 +-
 7 files changed, 146 insertions(+), 131 deletions(-)

-- 
2.53.0


