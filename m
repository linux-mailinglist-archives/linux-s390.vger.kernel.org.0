Return-Path: <linux-s390+bounces-17984-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCn6AjbNwmkBmQQAu9opvQ
	(envelope-from <linux-s390+bounces-17984-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 24 Mar 2026 18:43:18 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C536531A301
	for <lists+linux-s390@lfdr.de>; Tue, 24 Mar 2026 18:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18866303CE2D
	for <lists+linux-s390@lfdr.de>; Tue, 24 Mar 2026 17:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4040822A;
	Tue, 24 Mar 2026 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R+DDNXzx"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA247407595;
	Tue, 24 Mar 2026 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374193; cv=none; b=i5JcOqYPQS2faeWl8TbIEnSMU+vlspX0fhXUpTE7dF+THJhfOyeEL2MrB4KRCLIUCnW4cOU9bJ3J2umwfKswXeQjRVogIh6V8yh7DkhC1rYBn/jna+wjlpFcxdP7vz+ncFHwzvHaoXRbrcfqt9jqRJ9Vo2Ym74b7qkca0XvII1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374193; c=relaxed/simple;
	bh=1qSIXo0m19cAxKPo380Ih7B5ATOAu3vPbQW5g7xtAHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r+g/FM18QGGPTWsUuU5rVR9PxKj7w0sAk++mHZt0a7c8gqNIccF440G/xpoLV9SiY+fc/tqlKNqdz79LKECimZHC4PNxphKwhu3EVD7eucVRrg3W9YOGRyQ3tWNo6N9DT/pX4e4sD80dT2MYyblK08rxWbF2pbvGg4/IYCMnJY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R+DDNXzx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O5arNh4178383;
	Tue, 24 Mar 2026 17:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1JfdQ1RRx6rYAwthg+TqbVVt4c9OO3u/Q1jROcGGA
	rc=; b=R+DDNXzxLQBz9tBX1Xf7fgY25hR/wSlcvlic38QXrmrinFsJRKemT3wCW
	imNYONaAwLEABVYMXG4yG2WMBr1hulCyMtDeIHDSWxB/h79ibv6Q1WgHdcHrMmhf
	vaY3Qlh2mhMDhbXnj+qnL1rDEa7s/WhAoQcIrnopxDgkf1t9uPrRMO06UFHH32GH
	vp1tBNNxkTvIfZBso1yl7xtyJUCjpuc+0dBZ/jReDsBtNERuZKcJy4bSoHgoLoGu
	aMuwA9m+NZ/6OB8Fkx7EgoIlX1YLab0pVWQlhOP76xgI1K4zYQpmLhZ3p4TH9zL9
	dij1j5MrN/Fm/KtuABtwtF5lgTPFA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9vwkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OGFD0l026685;
	Tue, 24 Mar 2026 17:43:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275ku11b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 17:43:07 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OHh3kM15860028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 17:43:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2887C20043;
	Tue, 24 Mar 2026 17:43:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1946420040;
	Tue, 24 Mar 2026 17:43:02 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.26.26])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 17:43:01 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v3 0/9] KVM: s390: More memory management fixes
Date: Tue, 24 Mar 2026 18:42:52 +0100
Message-ID: <20260324174301.232921-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kVY4yu5PhNn4fzeLKICl3squ3-2eIz8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNCBTYWx0ZWRfX/AYT2hrlaBJg
 MpCg9MdVkx2JzzgTUMcQLp9Zzb56tm00d+cxFPglrjLKVNRgiQ+XPlMBxcV0mmjOP/hRWRHtKYN
 hCNY2wQaGZBiRuAiqP3I0p9+rMxYevSJ9r+N5h2kSML/Edu59PIYDB/uErIAHKtXWmteLoAscps
 uG74aRtkNmpODi3xQMP9SEuI8zdEUAerVR+j3/yC+4AcSmA36i66l47cnC1E3hqPIpQ5OXfdmcK
 qUU1Z+Z51LLQM2KtARhoalPO3PhFfmUvpw3boazlSrU0yp2H/JaZ1mFAx2Rp6Qh7C35W3WucdyD
 jbUkLI/nThdl8ft6S7Ygse7ZyzKxmQTCYfeMMEUGHPAgUO62dI9Qpl/GQZe0kOmBtno+wt0tVyJ
 auWw3aLyGktSOHu1CJzNdhVuB4C6K7MTPzr+918AXPzXslyD7MDeUpvbiV9UnnZO4+JbWLUN3xA
 qx2Eqjat+Q5LJlrJgTg==
X-Proofpoint-GUID: kVY4yu5PhNn4fzeLKICl3squ3-2eIz8x
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c2cd2c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=PB9vAftXpDJCUqic_UQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240134
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17984-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-s390];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: C536531A301
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes some bugs that have been recently introduced with the
big gmap rewrite.

Most of the fixes are related to vSIE (nested guests), although some
are more general. The last patch fixes an issue introduced last year.

v2->v3
* fix a typo in the code (missin negation in patch 2)
* fix pre-existing alignment issue in _gmap_crstep_xchg_atomic()
* fix nested guest memory shadowing
* properly handle another possible place in _do_shadow_crste() where an
  unshadowing event could be triggered
* fix _gaccess_do_shadow() to properly handle the case of real-address
  asces for the nested guest
* fix some typos

v1->v2
* propagate vsie notification bit when splitting a large page
* replace gmap_crstep_xchg() with gmap_crstep_xchg_atomic(); let the
  callers properly deal with races
* do not attempt to protect guest page table when the nested guest is
  running in a real address space
* fix return value of KVM_S390_VCPU_FAULT in case of error


Claudio Imbrenda (9):
  KVM: s390: vsie: Fix dat_split_ste()
  KVM: s390: Remove non-atomic dat_crstep_xchg()
  KVM: s390: vsie: Fix check for pre-existing shadow mapping
  KVM: s390: vsie: Fix nested guest memory shadowing
  KVM: s390: Fix gmap_link()
  KVM: s390: vsie: Fix refcount overflow for shadow gmaps
  KVM: s390: vsie: Fix unshadowing while shadowing
  KVM: s390: vsie: Fix guest page tables protection
  KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl

 arch/s390/kvm/dat.c      | 102 +++++----------------------
 arch/s390/kvm/dat.h      |  11 +--
 arch/s390/kvm/gaccess.c  |  58 ++++++++++-----
 arch/s390/kvm/gmap.c     | 149 +++++++++++++++++++++++++++++----------
 arch/s390/kvm/gmap.h     |  26 +++----
 arch/s390/kvm/kvm-s390.c |  18 ++++-
 arch/s390/kvm/vsie.c     |   4 +-
 7 files changed, 204 insertions(+), 164 deletions(-)

-- 
2.53.0


