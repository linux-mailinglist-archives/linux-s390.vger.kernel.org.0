Return-Path: <linux-s390+bounces-17653-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOAAI1+4u2lHmwIAu9opvQ
	(envelope-from <linux-s390+bounces-17653-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 09:48:31 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B52C80DC
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 09:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 939F13021439
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 08:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061BB3A1A43;
	Thu, 19 Mar 2026 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KzibydEm"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1489389E1F;
	Thu, 19 Mar 2026 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910098; cv=none; b=rolqEJW39Vx2Oi+vi8IcKFrtoyzqMKD6ZKRiobPMWxwbA+1PRJx3ufuThjrLBPfrdimpQTjGk4c0i+vcQv9yZ7bwUPP+S5qN6F7doBnwmnxHbK7bsZSH7FaPRcuIRyPO6fdra7XK2wm/Nv4/dThhxInLXlLrSZlQAOF9mn5r8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910098; c=relaxed/simple;
	bh=955ZIVhYtNpJ59DyTrQSQhtcl+EmqAghs45/hrOI47s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIxx6/dMFSCGGLabL2e/xdxjLvldW9wCyfejT9+Cf5mD0aLBFYDnFgzCEAa+c/rL76n/lBAsoNH3yHT6ubEt+WvtMIPwwbe9MobydoH22EIc8f09+yBboSCNeZ3z4kXO9Z/NtxZP3kspTy1H0Hkkk2GSegDJYtBBt3w2MAn/JJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KzibydEm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IKB3MU940706;
	Thu, 19 Mar 2026 08:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JU5l0Jj02SsqHfskF5jjmP2Wg7c+Zxu3xhbWXIqdD
	TE=; b=KzibydEmGvqG50UwU3PX9g6eqviRc1oeoLOi6l1LNq+HvY2PFa9Tq1uQw
	rD9u8EOgx3fCLwTHwcfrew6zAtSlOLwffM3PWfbM6XXzwu0v4P8VlqfrP0+WeiOX
	Arlrl2ZMRp6h4j6eFDlYKHLt/GDbJ+lcA9LLFrdi17xi0aZkAwOl4sJ/GKg2SJfm
	gy9fo9sN2f8udIbuCbUvTI7m25QVOncMAAjfemIACGuNRcBogC+3LMApfGbzN3LH
	m2KXdxpzU13F0kyTyebbH3oKzWX21Xu+zj9OUgqiuYT6EuXd00kmiJ1tzfzF0ScP
	t8hdfGSi9mXpuWnUZqq8j9Xl2tzWA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybse1xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:48:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J5cTAo032333;
	Thu, 19 Mar 2026 08:48:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7k1hqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 08:48:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62J8m0Ts46399990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 08:48:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FA572004B;
	Thu, 19 Mar 2026 08:48:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07A992005A;
	Thu, 19 Mar 2026 08:48:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 08:47:59 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
Subject: [PATCH v5 0/1] perf record: Add support for arch_sdt_arg_parse_op() on s390
Date: Thu, 19 Mar 2026 09:47:53 +0100
Message-ID: <20260319084754.3838828-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69bbb84a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=ZNFJW8Vw3D9jWG06bIQA:9
X-Proofpoint-ORIG-GUID: 3ePFdRpvdVLUoF2dWq9QzJTx9ssMngLo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA2OCBTYWx0ZWRfX5BpdOIgkL78a
 zBwq1f1EMvXzZx6Ga+TYoPLIISg3xqW/NBe89HjSnbokSJEf3mQQRFnqmAVkBEmpHqEV6qxE9k5
 aLtki5m5zaZGz+ZBtG5bmvFhG9bXCl9gBfM45jT2feB0AqMU4rhb+LsBWAV07pTC9FIJYh6+BuM
 e+W8GAirj86/DoJ/SwsXKMs1f6AGcT8AgTLG0GF4DKXdWqpFlZ5t/K8ZpQxXqVBd6dJ3sSDZZUr
 P5hLnCm6miITsuN86pYzgnbHBZIGllmELLoBOd9noex7DH61O3mMcVPezn+f8Ml4gVMDLVLMmIE
 WV7ceLZZGHpT8U5Q/URifN7FYac6HWpQxGNoRcY5kGja88RZg8o7WTfclgoAagaJMHF1C2KXuxk
 eyb9B1f8Iy9BtkmLNre6EGTFc5dOzdEcN2CI3ZVgvCjvKxZpKf1qv6ioVV50lXzVy6r+atvkWKh
 fgvNQAapMuh7izvjFlw==
X-Proofpoint-GUID: gDLl_13xqtNl2wHd4wG7HfLLm1SkQaTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190068
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17653-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-s390];
	FROM_NEQ_ENVFROM(0.00)[tmricht@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 6A1B52C80DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

V5: Add comments from Ian and Sashiko:
    Moved version history to cover letter
    Added missing comment line +NUM(%rREG).
V4: Add comments from Ian and Sashiko:
    Reset variable initialized to zero on error
    Rework regular expression and reduce to one case.
V3: Add comments from Ian
    Print register expression without leading 'r' (wrong).
V2: Add comments from Sumanth Koirkkar

Thomas Richter (1):
  perf record: Add support for arch_sdt_arg_parse_op() on s390

 .../perf/util/perf-regs-arch/perf_regs_s390.c | 78 +++++++++++++++++++
 tools/perf/util/perf_regs.c                   |  3 +
 tools/perf/util/perf_regs.h                   |  1 +
 3 files changed, 82 insertions(+)

-- 
2.53.0


