Return-Path: <linux-s390+bounces-19950-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEBaJrNDD2r/IQYAu9opvQ
	(envelope-from <linux-s390+bounces-19950-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 21 May 2026 19:41:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1655AA68D
	for <lists+linux-s390@lfdr.de>; Thu, 21 May 2026 19:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C83A33458C8
	for <lists+linux-s390@lfdr.de>; Thu, 21 May 2026 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96343E122D;
	Thu, 21 May 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLb9N0JG"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3E13D9DB7;
	Thu, 21 May 2026 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383014; cv=none; b=Ds1/NkMfs4ZDxD9bb1YMUzjunc08NGcSrKuXlfRLu6Oeu06sNIVYza5sah1IbHDDzAkB3u2cVjAK6YqzUMav5N3ZVz7ZEreKzkpqYbpgrr/YQ1kb72WbBV7T9uXea68YVMewJHA92pGRvGVWyw7OBCIRus6wVTyk8u0b7Ifwtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383014; c=relaxed/simple;
	bh=rSsUhmRk1T4KmL0Xs0s66E1ODoRrF1MQgNpA5nUuYjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9eh6tnqhZFR5G8Nr5J9EfO65XUs1tUa9omou8mj4N+HBIxQ8XM6SufCrV90vwIPPjNHejQuqjnqEtDc1mksR5vJGH6pW99zGT0Jj13bcRCDUVr+5DOUM2VDIiQXEKpqasDpvprAQBYFRIN+F8FFMek8QnDtaSnYOLpZMKVuxkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLb9N0JG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFQw32685729;
	Thu, 21 May 2026 17:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Kk32Fc2nYKGVpKhLP
	afzmCRMMiatjxD09qo2Q8kAwhE=; b=dLb9N0JG+M2eQmPZz2zI5926VRj9XAeJc
	7PyNo8cKsh7RjkM4dOpDkq6J0Jm1kpZD381IL3+3nBpRoxj0xoVErW8qyrbpHXOD
	TMN46AgqVaIsvfWm7h1byMXfb2l7kNWCiHfhRyWYYt3JXmumpfA3dta3YnqbS5as
	Y5b1c5RlNIogq/bFvTH9W31zWSxsTR2lrZTsMyx1rhq4wJEKD4T9usAmqEC3eIYF
	GH7J/wXsvGqkEGZVkasR9fMIFVwCQCBUAC8lKIqAKuvnqbGGIPwYA6W2eKd77JRz
	7ZWJqSaUzacA4xL6YqViUvNArjrep2k1T9XHBVyBvh9I2gLjZjL4A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88py4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64LGs5Qw019147;
	Thu, 21 May 2026 17:03:10 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyd10t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 17:03:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64LH36nI28836256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 17:03:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94C152004B;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BE0D2005A;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 17:03:06 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
        jbaron@akamai.com, aliceryhl@google.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, boqun@kernel.org,
        gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
        a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
        rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] rust/bindgen_parameters: Mark s390 types as opaque to prevent repr conflicts
Date: Thu, 21 May 2026 18:56:21 +0200
Message-ID: <20260521165622.279953-4-japo@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521165622.279953-1-japo@linux.ibm.com>
References: <20260521165622.279953-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: SPJsgGQsoZl2EpRPkzmAqnR9N9NMPmE3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2NyBTYWx0ZWRfX9hjq97K6vsql
 9P69+ib0q++v6WFq9dIB9h8N/SPTWaR4CRN01eF1X1nsarQjte+huBj/zS+JHGT/C5OsxjDLWZj
 1OeKP2pvQ+BwiXkrAxV387XaUkTTgHl2aOshTKH7Bat3w/obJCEgl3sVnBFZD8m6sHgYVF3YUiB
 HLAqAW4cuNpvwqzadkJujQKiuMssgQ1QTIzSN8CRGFvNuF7O74MxT9o62F80iJblcsUWzikCRY0
 Fkk966T6Q2Rt6H0doQQ+qwb2MDyBW+sc/Sdtcgfc9SSDBPvoc1crpd1bLEP9h219Bn1oN7w51DE
 SNjwQkq8yJvZQg0mpFW93W+xveaIF0qLnuKBsettVDNdnRyrhQVGcyj5Qevxpb1nfojxMW0AZj5
 4mXkRegp/bmu+57ysc/JCj3kVuKEb57hVb5Pc284vchScyeXOZalcTy0AVIlt9Vf64JpYUeVOSw
 DybuI5ijHZ63XCQ+hUg==
X-Proofpoint-GUID: 1-ct3DQhwc9w3nwZqObQUbbGFnv8kX-p
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0f3acf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=_2yia0w1AAAA:8
 a=VnNF1IyMAAAA:8 a=Ulcv6RcHQRQKaI22KjAA:9 a=4yAS8WwzZ1jAEY03B-5r:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210167
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
	TAGGED_FROM(0.00)[bounces-19950-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,kernel.org,garyguo.net,protonmail.com,umich.edu,goodmis.org,vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[japo@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid,garyguo.net:email];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0E1655AA68D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bindgen attempts to generate Rust layouts for a number of s390 structs
that are packed but contain, or transitively contain, aligned fields.
Rust rejects such layouts with E0588 ("packed type cannot transitively
contain a #[repr(align)] type").

Add the affected s390 types to the opaque type list so bindgen emits
opaque blob types instead of full representations. This matches existing
workarounds for x86 types such as alt_instr and x86_msi_data.

References: https://lore.kernel.org/all/e5c7aa10-590d-0d20-dd3b-385bee2377e7@intel.com/
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 rust/bindgen_parameters | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 6f02d9720ad2..8402b0c93545 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -14,6 +14,13 @@
 --opaque-type alt_instr
 --opaque-type x86_msi_data
 --opaque-type x86_msi_addr_lo
+# s390-only: same packed/align issue as above (E0588).
+--opaque-type lowcore
+--opaque-type tod_clock
+--opaque-type tpi_info
+--opaque-type uv_cb.*
+--opaque-type uv_secret.*
+--opaque-type zpci_fib
 
 # If SMP is disabled, `arch_spinlock_t` is defined as a ZST which triggers a Rust
 # warning. We don't need to peek into it anyway.
-- 
2.51.0


