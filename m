Return-Path: <linux-s390+bounces-21245-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kU26DjnWPGpatAgAu9opvQ
	(envelope-from <linux-s390+bounces-21245-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 25 Jun 2026 09:18:17 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9166C34CD
	for <lists+linux-s390@lfdr.de>; Thu, 25 Jun 2026 09:18:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=Dz9LAaTD;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21245-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21245-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A67F930233F5
	for <lists+linux-s390@lfdr.de>; Thu, 25 Jun 2026 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C0A212564;
	Thu, 25 Jun 2026 07:18:14 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F63171CD
	for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2026 07:18:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782371894; cv=none; b=SUk7C4pwMZDEIMktZNUd97u0+f96En8GvRH++743xg0jbS1z+UhpqpM54MlF85I1RiDZV6wzJmRDgukmVi1GeO1eDHOpKtV/Rjce/ZAupILyE+/Mlj9Y/crQOKwM3bN8A/B8XrtbkjUBltZbOePq/8ywH2e7rXGGKyKGAZjnfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782371894; c=relaxed/simple;
	bh=Hc0EwGx4jJZsrtGBfIIkfzgW1BW+9WJ7sTvzVXCKHH4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tC8avv3me8QRCeOhcIN7RXr2EX7LOTFyGSkQ29W4904UmF05swzzB68BQ8ZCmf/psUej3TBobGKAQZgzTA2QWa06K4cRmEvybkNjDxa+iwcZpapYmckKVxwFsHMXrKU6Vs1Aoe99S6gtzv3iHfa8Agh7De6b61z7aKAqmHHmZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dz9LAaTD; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3md9E2927899;
	Thu, 25 Jun 2026 07:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=sEEdxNZSBJNJmGv9wYj4QSSkaFgOHTj0yQ4s0M1facU=; b=Dz9LAaTDW3JS
	YaWTS7AyvdmS/pj3l5xGauztHUmE7YMhRTUwJ5hA4vJ2xnCaZYdjN7/BFzZNQ7kL
	exlhqJ70GRhxB0ovXEmEwyq0wh4FzawJGbg3Xx8z2RsqgCPduZO7WqpYrvGKUMH2
	oG0Unux8nlt40RcpD3VTOxsUe16oB7Bt3dDPCF1Uwq3R5YPVJuYbQHy4Kh6SIFKk
	VDXtQDh5Ax4hX/NPPsBmBoiHQFS4OHHUPQsRs35/szvD6MKx3rd4QLZmAuVubVea
	GEuC1w3sXUByEH7loQneUFopv1F6FxDq5C4Ppa0idSlXriNc9DDxV4HOiSsfPSs7
	fKsjdrlcNQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gr8j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 07:17:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P6nfvK007978;
	Thu, 25 Jun 2026 07:17:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qn5yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 07:17:56 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65P7Htgu33161972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jun 2026 07:17:55 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A4875805D;
	Thu, 25 Jun 2026 07:17:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8345F58052;
	Thu, 25 Jun 2026 07:17:54 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jun 2026 07:17:54 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Jun 2026 09:17:54 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 07/18] target/s390x: Support AES CTR for cpacf kmctr
 instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <a948d24d-f9cb-4d67-bf46-007d6de3c523@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-8-freude@linux.ibm.com>
 <a948d24d-f9cb-4d67-bf46-007d6de3c523@linux.ibm.com>
Message-ID: <e6a894618afbc5e45e66fafb3373de74@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bS9YgefBNZ6Tvm91IRGUITunABBfl7Ho
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA1NyBTYWx0ZWRfXyI0FBARY3hEw
 BBJ93Aw+iOQjwmVfnsia/NmreHR+qcE1PGYkaspgK1ro7tvOT2cqV/KGt2kIceyKpWH73fxFDUR
 6C6z7RymoVgHsgcY+rg5ljR9PfEsIqM=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3cd625 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=LTUHX7r_CpFhJwewSl8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA1NyBTYWx0ZWRfXzDTc5WLNZj4x
 9M6ejh3mDwTScyetiUaxwUuBlenrov8QS+9up+N7w5NrygWyU0pMfmgTtQ/eoX6sYmNQBDgvJRY
 IW41tM+8SFk5vufXfs3nQ8/S+U8ayBkgLy2Nl5G+TT5h8I5YHrcK2jhfTGg+YO4A8nhndRUTSsa
 /AO2e4cuqNB3RWpg7odGPr7AHoklr9rL3j+0V00S7vZxJDoAJaagTkENo7TKKXTVJ8rB/PDFsZ3
 Wvjc1fE6Uy9+UhRTL6x4AuDoam7W3SrA4sqTsDrNxBuJMfkERJTq8Mb2UPs+7Rnns7co/IJudDh
 6PrDJeaODSIBC9lpafHcFL05F5P7Vn8UPnUzEltO5p3lhUOdVxoaXXrdSaL79wFiHqkhPCewzav
 ZWycG4N172i5fn9uUGTl9nMXUKz03ywLOFiy44glTXFAlc7PRNPiHpnJzVyemJohgBO+zu074G/
 K5ozg3632GGAoNGKExA==
X-Proofpoint-ORIG-GUID: bS9YgefBNZ6Tvm91IRGUITunABBfl7Ho
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250057
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:iii@linux.ibm.com,m:richard.henderson@linaro.org,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux390-list@tuxmaker.boeblingen.de.ibm.com,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:fcallies@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[freude@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21245-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[freude@linux.ibm.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	HAS_REPLYTO(0.00)[freude@linux.ibm.com];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B9166C34CD

On 2026-06-24 19:26, Ilya Leoshkevich wrote:
> On 6/24/26 10:10, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KMCTR_AES_128, CPACF_KMCTR_AES_192
>> and CPACF_KMCTR_AES_256 for the cpacf kmctr instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         |  5 +++
>>   target/s390x/tcg/cpacf_aes.c     | 76 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c | 24 ++++++++++
>>   4 files changed, 108 insertions(+)
> 
> [...]
> 
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -213,3 +213,79 @@ int cpacf_aes_cbc(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return !len ? 0 : 3;
>>   }
>> +
>> +int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                  uint64_t *ctr_ptr_reg, uint32_t type,
>> +                  uint8_t fc, uint8_t mod)
>> +{
>> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>> +    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>> +    uint64_t addr, len = *src_len_reg, done = 0;
>> +    int i, keysize, addr_reg_size = 64;
>> +    uint8_t key[32];
>> +    AES_KEY exkey;
>> +
>> +    g_assert(type == S390_FEAT_TYPE_KMCTR);
>> +
>> +    switch (fc) {
>> +    case 0x12: /* CPACF_KMCTR_AES_128 */
>> +        keysize = 16;
>> +        break;
>> +    case 0x13: /* CPACF_KMCTR_AES_192 */
>> +        keysize = 24;
>> +        break;
>> +    case 0x14: /* CPACF_KMCTR_AES_256 */
>> +        keysize = 32;
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
> 
> A general comment; I think I've seen this in previous patches as well.
> Would it make sense to properly define constants like
> CPACF_KMCTR_AES_128 and drop comments? Or, if the goal is easier
> cross-checking with POp, hardcode decimal numbers, since POp specifies
> them in decimal?
> 

As I am about to write some tests for all this CPACF support there would
be a benefit in having all this as constants or defines in a header file
instead of hardcoded values on every switch statement. So I am about to
introduce a some cpacf.h with all these values for the next version.

>> +
>> +    if (!(env->psw.mask & PSW_MASK_64)) {
>> +        len = (uint32_t)len;
>> +        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
>> +    }
>> +
>> +    /* length has to be properly aligned. */
>> +    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
>> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +    }
>> +
>> +    /* fetch key from param block */
>> +    for (i = 0; i < keysize; i++) {
>> +        addr = wrap_address(env, param_addr + i);
>> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
>> +
>> +    /* expand key */
>> +    AES_set_encrypt_key(key, keysize * 8, &exkey);
>> +
>> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>> +        /* read in nonce/ctr => ctr */
>> +        aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
>> +        /* encrypt ctr => buf */
>> +        AES_encrypt(ctr, buf, &exkey);
>> +        /* read in one block of input data => in */
>> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>> +        /* xor input data with encrypted ctr => out */
>> +        aes_xor(in, buf, out);
>> +        /* write out the processed block */
>> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>> +        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
> 
> Same comment as in the previous patch.
> 
> 
> Otherwise:
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> [...]

