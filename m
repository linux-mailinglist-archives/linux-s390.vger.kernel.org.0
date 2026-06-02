Return-Path: <linux-s390+bounces-20373-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MfKIESvtHmraZAAAu9opvQ
	(envelope-from <linux-s390+bounces-20373-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 16:48:11 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F7562F6FA
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 16:48:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=nBb9LAhd;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20373-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20373-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 714FB30C548A
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94A3EC2F8;
	Tue,  2 Jun 2026 14:24:07 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513713ADBA1;
	Tue,  2 Jun 2026 14:24:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410247; cv=none; b=fgn3UmsXDRIEp0B1oK/M+C6JQ9EII5Oxqbt8XPjxgrE4Iq/VI4H7TLSi+AwGy8HFb4lxLAqtoP2s6Jh3q8JS46TOJ30aAdxc84kyBEYxa3whs0Lgimz25jNX0HC+cA7DsYXZDHSDomYv9yGlrXe6dvdF9+g8MXLSFcoUC54NIVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410247; c=relaxed/simple;
	bh=SaNczAbmkJpcfaU3txSBeNvp40SgE4aMw2pPxEtV7zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGdGI++Is7YQvTfxY6WRCyrBEMenMSVPgHikJp1ZTnEMGr7d+iev50L9H9DwKGAH8+gJyMpVEicOeSLhYbtWpa/l4VLgQmT47nFhVBP4pM0br7fdttEXuBc8KsxZRJliWkEgxl+KiI2KrrWyOpGuObYipAxg404RDahc/uqEETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nBb9LAhd; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6522Kt9j2852524;
	Tue, 2 Jun 2026 14:24:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fRNRlHxSJh5/n0ky1AnmsP0PLdU54P2ShM36Xlz04
	S8=; b=nBb9LAhdBQbJGvuWsnEvxlwUmFiaxxx/41BjC2MgmXXNtWABzwHezSRRI
	9jLvzb+R2okt28MM51hD8POretDkbR/6LobLNy10tIJkq5/iM0chfFl41SUVq2WM
	MHzKRVTYfKZVMZ1PMiRjqIGv5TiL6B7cGa9IWWJusQAMIErB0L6IN7MSdp3nqB+/
	BY7juwpE6aRtJeXAz3SOpUG2d222esHbyArCa5Cc526tQOorYOvMxAZlWNGb46RY
	FsDuQNsubMZRXiKp8kBYqlHqpyZuAZ74AH4cpCEC1FT3yf30ngiZUd8Dw3reW3gu
	Vvpar5Y7CRoEDrjJ74dewt/zK3Z6A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht5v8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652DOALa007334;
	Tue, 2 Jun 2026 14:24:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k3mpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652ENuNR28967378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 14:23:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAF1220043;
	Tue,  2 Jun 2026 14:23:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABA3C20040;
	Tue,  2 Jun 2026 14:23:56 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 14:23:56 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 00/10] KVM: s390: More gmap and vsie fixes
Date: Tue,  2 Jun 2026 16:23:46 +0200
Message-ID: <20260602142356.169458-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U077jPze0StFdvF9IwnwmYk1FcTfmeZJ
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1ee783 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=n0ANnZiPoOazgFQFfi4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzNiBTYWx0ZWRfX559LSFFmDVnt
 dzGQASVNTU0V/i/0m4p+OTL5SEO5fBd8wZuhDVv3AZAG1bpmyOjLXJnbDasiuN1i++Ud7pwGYAt
 52dBWVdccraDx22OXKKTdC1PzgKdKTfq6n5+0pswTRKhiyPnSk4X7DUQTDEAFqhd4yjLqiOJZrr
 zoeGNgkabb64fim2dBvrnVIQ9YOJFUDQPQd2zYVXZ5sJO6VpdP4nktLKFTPdWPOHUb/iMQEvpDw
 Yu9KZXRMTu6ycLcgMOmR8SDLutCOYZ+MeTk2y2Z/AqguqCl7qPsIijy357bZIIWbRb0POkZCjAf
 VPY9piayEjbTey3HYcTVHMoNoXXYm1TTJf1/ZhlilonbaCYo/SlUBKFJLxl5Md4R0uJ+4XjLKq8
 3zNEg4pgBN8aIkh3Bh20zclzpLt2GzYjYBsTjzyn1c94Hz7EHZJsARYMPYpRIy+MLXGueITz1Cm
 UrQf8el7X/dAP6kRAkA==
X-Proofpoint-ORIG-GUID: U077jPze0StFdvF9IwnwmYk1FcTfmeZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020136
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20373-lists,linux-s390=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:from_mime,linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8F7562F6FA

Another batch of fixups for gmap and vsie. Some minor fixes, some
not-so-minor fixes that could have caused guest corruption under
particular circumstances.

v2->v3:
* Improve patch 8 to avoid a possible race and minor issue when the
  given limit is smaller than a page
* Fix possible reference leak in fault-in code
* Fix possible warning if gmap_helper_zap_one_page() is called on a
  migration entry

v1->v2:
* Reordered the patches
* _gmap_crstep_xchg_atomic() will now attempt to clear the vsie_notif
  bit when failing due to unshadowing; this prevents potential loops
* try_get_locked_pte() will now return -EAGAIN instead of NULL if the
  pte was reached but the lock was contended; this prevents potential
  loops
* _kvm_s390_pv_make_secure() will now attempt mmap_read_trylock(); this
  prevents try_get_locked_pte() from potentially racing
* Take kvm->slots_lock instead of kvm->slots_arch_lock in
  kvm_s390_set_mem_control() when handling KVM_S390_VM_MEM_LIMIT_SIZE,
  and also take kvm->lock.
* Minor cosmetic / style fixes.

Claudio Imbrenda (10):
  KVM: s390: Fix _gmap_unmap_crste()
  KVM: s390: Fix _gmap_crstep_xchg_atomic()
  KVM: s390: Avoid potentially sleeping while atomic when zapping pages
  KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()
  KVM: s390: vsie: Fix rmap handling in _do_shadow_crste()
  KVM: s390: Fix fault-in code
  KVM: s390: Lock pte when making page secure
  KVM: s390: Prevent memslots outside the ASCE range
  KVM: s390: Fix possible reference leak in fault-in code
  KVM: s390: Remove ptep_zap_softleaf_entry()

 arch/s390/include/asm/gmap_helpers.h |   1 +
 arch/s390/kvm/faultin.c              |  30 +++----
 arch/s390/kvm/gaccess.c              |  11 +--
 arch/s390/kvm/gmap.c                 |  19 +++-
 arch/s390/kvm/gmap.h                 |   3 +
 arch/s390/kvm/kvm-s390.c             |  33 +++++--
 arch/s390/kvm/priv.c                 |   8 +-
 arch/s390/kvm/pv.c                   |  21 ++++-
 arch/s390/mm/gmap_helpers.c          | 128 +++++++++++++++------------
 9 files changed, 165 insertions(+), 89 deletions(-)

-- 
2.54.0


