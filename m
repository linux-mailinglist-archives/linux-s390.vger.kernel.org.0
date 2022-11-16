Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2990C62BAD8
	for <lists+linux-s390@lfdr.de>; Wed, 16 Nov 2022 12:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiKPLFs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 16 Nov 2022 06:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiKPLFG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Nov 2022 06:05:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE92D1EA;
        Wed, 16 Nov 2022 02:51:18 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGAiDmi005645;
        Wed, 16 Nov 2022 10:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding : sender;
 s=pp1; bh=bY/g/Wr+ay5adr2ZxV+H2okn7G+6oc9CLDmKd39nMy4=;
 b=Y/jf6K4OJYyHzPf5Y2131begLjSFEqYWLL+O1Xa/64CQXi0gU7by4dodxA/WOV5hexo0
 swnQd9A3SXQAiEl0v7IAGM/dvJrUoNk7CYUJGZxVEUpXnrcte2AvPgX54FRmtOr8ZDFa
 hreVgIKIv3QC2clNBFsBRyizLRudmJHOQ9oMB4kUuI1AyzVlCYYQPvxgB37P4CUTlLj+
 /2L9OlgQpfJ5FVdOGtg3qpRHm1Ng2gmZ9Q0FAez29LoNYgRJT85enZ1E3UH2Hf/gOinS
 ByudGzFJa7q3231gun4DxVKB+tZzB2711DuXSzNHHUWXFSwsy59xoTVfdpYwKh9NYE2N kQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvxca07gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 10:51:16 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGAnrgj026827;
        Wed, 16 Nov 2022 10:51:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3kt3494anf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 10:51:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AGApBPH5767698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 10:51:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F35DD4C044;
        Wed, 16 Nov 2022 10:51:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D54644C040;
        Wed, 16 Nov 2022 10:51:10 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.145.81.107])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Nov 2022 10:51:10 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.96)
        (envelope-from <bblock@linux.ibm.com>)
        id 1ovG0c-006cVF-1W;
        Wed, 16 Nov 2022 11:51:10 +0100
From:   Benjamin Block <bblock@linux.ibm.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Steffen Maier" <maier@linux.ibm.com>
Cc:     Benjamin Block <bblock@linux.ibm.com>,
        "Fedor Loshakov" <loshakov@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] zfcp: fix double free of fsf request when qdio send fails
Date:   Wed, 16 Nov 2022 11:50:37 +0100
Message-Id: <979f6e6019d15f91ba56182f1aaf68d61bf37fc6.1668595505.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Organization: IBM Deutschland Research & Development GmbH, Vorsitz. AufsR. Gregor Pillen, Geschaeftsfuehrung David Faller, Sitz der Gesellschaft Boeblingen, Registergericht AmtsG Stuttgart, HRB 243294, https://www.ibm.com/privacy
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _-Dsj_JS7nzlV3eQ2yhiU9H76KUsgZ0_
X-Proofpoint-GUID: _-Dsj_JS7nzlV3eQ2yhiU9H76KUsgZ0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_01,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We used to use the wrong type of integer in `zfcp_fsf_req_send()` to
cache the FSF request ID when sending a new FSF request. This is used in
case the sending fails and we need to remove the request from our
internal hash table again (so we don't keep an invalid reference and use
it when we free the request again).

In `zfcp_fsf_req_send()` we used to cache the ID as `int` (signed and 32
bit wide), but the rest of the zfcp code (and the firmware
specification) handles the ID as `unsigned long`/`u64` (unsigned and 64
bit wide [s390x ELF ABI]).
    For one this has the obvious problem that when the ID grows past 32
bit (this can happen reasonably fast) it is truncated to 32 bit when
storing it in the cache variable and so doesn't match the original ID
anymore.
    The second less obvious problem is that even when the original ID
has not yet grown past 32 bit, as soon as the 32nd bit is set in the
original ID (0x80000000 = 2'147'483'648) we will have a mismatch when we
cast it back to `unsigned long`. As the cached variable is of a signed
type, the compiler will choose a sign-extending instruction to
load the 32 bit variable into a 64 bit register (e.g.:
`lgf %r11,188(%r15)`). So once we pass the cached variable into
`zfcp_reqlist_find_rm()` to remove the request again all the leading
zeros will be flipped to ones to extend the sign and won't match the
original ID anymore (this has been observed in practice).

If we can't successfully remove the request from the hash table again
after `zfcp_qdio_send()` fails (this happens regularly when zfcp cannot
notify the adapter about new work because the adapter is already gone
during e.g. a ChpID toggle) we will end up with a double free.
    We unconditionally free the request in the calling function when
`zfcp_fsf_req_send()` fails, but because the request is still in the
hash table we end up with a stale memory reference, and once the zfcp
adapter is either reset during recovery or shutdown we end up freeing
the same memory twice.

The resulting stack traces vary depending on the kernel and have no
direct correlation to the place where the bug occurs. Here are three
examples that have been seen in practice:

  list_del corruption. next->prev should be 00000001b9d13800, but was 00000000dead4ead. (next=00000001bd131a00)
  ------------[ cut here ]------------
  kernel BUG at lib/list_debug.c:62!
  monitor event: 0040 ilc:2 [#1] PREEMPT SMP
  Modules linked in: ...
  CPU: 9 PID: 1617 Comm: zfcperp0.0.1740 Kdump: loaded
  Hardware name: ...
  Krnl PSW : 0704d00180000000 00000003cbeea1f8 (__list_del_entry_valid+0x98/0x140)
             R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
  Krnl GPRS: 00000000916d12f1 0000000080000000 000000000000006d 00000003cb665cd6
             0000000000000001 0000000000000000 0000000000000000 00000000d28d21e8
             00000000d3844000 00000380099efd28 00000001bd131a00 00000001b9d13800
             00000000d3290100 0000000000000000 00000003cbeea1f4 00000380099efc70
  Krnl Code: 00000003cbeea1e8: c020004f68a7        larl    %r2,00000003cc8d7336
             00000003cbeea1ee: c0e50027fd65        brasl   %r14,00000003cc3e9cb8
            #00000003cbeea1f4: af000000            mc      0,0
            >00000003cbeea1f8: c02000920440        larl    %r2,00000003cd12aa78
             00000003cbeea1fe: c0e500289c25        brasl   %r14,00000003cc3fda48
             00000003cbeea204: b9040043            lgr     %r4,%r3
             00000003cbeea208: b9040051            lgr     %r5,%r1
             00000003cbeea20c: b9040032            lgr     %r3,%r2
  Call Trace:
   [<00000003cbeea1f8>] __list_del_entry_valid+0x98/0x140
  ([<00000003cbeea1f4>] __list_del_entry_valid+0x94/0x140)
   [<000003ff7ff502fe>] zfcp_fsf_req_dismiss_all+0xde/0x150 [zfcp]
   [<000003ff7ff49cd0>] zfcp_erp_strategy_do_action+0x160/0x280 [zfcp]
   [<000003ff7ff4a22e>] zfcp_erp_strategy+0x21e/0xca0 [zfcp]
   [<000003ff7ff4ad34>] zfcp_erp_thread+0x84/0x1a0 [zfcp]
   [<00000003cb5eece8>] kthread+0x138/0x150
   [<00000003cb557f3c>] __ret_from_fork+0x3c/0x60
   [<00000003cc4172ea>] ret_from_fork+0xa/0x40
  INFO: lockdep is turned off.
  Last Breaking-Event-Address:
   [<00000003cc3e9d04>] _printk+0x4c/0x58
  Kernel panic - not syncing: Fatal exception: panic_on_oops

or:

  Unable to handle kernel pointer dereference in virtual kernel address space
  Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803
  Fault in home space mode while using kernel ASCE.
  AS:0000000063b10007 R3:0000000000000024
  Oops: 0038 ilc:3 [#1] SMP
  Modules linked in: ...
  CPU: 10 PID: 0 Comm: swapper/10 Kdump: loaded
  Hardware name: ...
  Krnl PSW : 0404d00180000000 000003ff7febaf8e (zfcp_fsf_reqid_check+0x86/0x158 [zfcp])
             R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
  Krnl GPRS: 5a6f1cfa89c49ac3 00000000aff2c4c8 6b6b6b6b6b6b6b6b 00000000000002a8
             0000000000000000 0000000000000055 0000000000000000 00000000a8515800
             0700000000000000 00000000a6e14500 00000000aff2c000 000000008003c44c
             000000008093c700 0000000000000010 00000380009ebba8 00000380009ebb48
  Krnl Code: 000003ff7febaf7e: a7f4003d            brc     15,000003ff7febaff8
             000003ff7febaf82: e32020000004        lg      %r2,0(%r2)
            #000003ff7febaf88: ec2100388064        cgrj    %r2,%r1,8,000003ff7febaff8
            >000003ff7febaf8e: e3b020100020        cg      %r11,16(%r2)
             000003ff7febaf94: a774fff7            brc     7,000003ff7febaf82
             000003ff7febaf98: ec280030007c        cgij    %r2,0,8,000003ff7febaff8
             000003ff7febaf9e: e31020080004        lg      %r1,8(%r2)
             000003ff7febafa4: e33020000004        lg      %r3,0(%r2)
  Call Trace:
   [<000003ff7febaf8e>] zfcp_fsf_reqid_check+0x86/0x158 [zfcp]
   [<000003ff7febbdbc>] zfcp_qdio_int_resp+0x6c/0x170 [zfcp]
   [<000003ff7febbf90>] zfcp_qdio_irq_tasklet+0xd0/0x108 [zfcp]
   [<0000000061d90a04>] tasklet_action_common.constprop.0+0xdc/0x128
   [<000000006292f300>] __do_softirq+0x130/0x3c0
   [<0000000061d906c6>] irq_exit_rcu+0xfe/0x118
   [<000000006291e818>] do_io_irq+0xc8/0x168
   [<000000006292d516>] io_int_handler+0xd6/0x110
   [<000000006292d596>] psw_idle_exit+0x0/0xa
  ([<0000000061d3be50>] arch_cpu_idle+0x40/0xd0)
   [<000000006292ceea>] default_idle_call+0x52/0xf8
   [<0000000061de4fa4>] do_idle+0xd4/0x168
   [<0000000061de51fe>] cpu_startup_entry+0x36/0x40
   [<0000000061d4faac>] smp_start_secondary+0x12c/0x138
   [<000000006292d88e>] restart_int_handler+0x6e/0x90
  Last Breaking-Event-Address:
   [<000003ff7febaf94>] zfcp_fsf_reqid_check+0x8c/0x158 [zfcp]
  Kernel panic - not syncing: Fatal exception in interrupt

or:

  Unable to handle kernel pointer dereference in virtual kernel address space
  Failing address: 523b05d3ae76a000 TEID: 523b05d3ae76a803
  Fault in home space mode while using kernel ASCE.
  AS:0000000077c40007 R3:0000000000000024
  Oops: 0038 ilc:3 [#1] SMP
  Modules linked in: ...
  CPU: 3 PID: 453 Comm: kworker/3:1H Kdump: loaded
  Hardware name: ...
  Workqueue: kblockd blk_mq_run_work_fn
  Krnl PSW : 0404d00180000000 0000000076fc0312 (__kmalloc+0xd2/0x398)
             R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
  Krnl GPRS: ffffffffffffffff 523b05d3ae76abf6 0000000000000000 0000000000092a20
             0000000000000002 00000007e49b5cc0 00000007eda8f000 0000000000092a20
             00000007eda8f000 00000003b02856b9 00000000000000a8 523b05d3ae76abf6
             00000007dd662000 00000007eda8f000 0000000076fc02b2 000003e0037637a0
  Krnl Code: 0000000076fc0302: c004000000d4	brcl	0,76fc04aa
             0000000076fc0308: b904001b		lgr	%r1,%r11
            #0000000076fc030c: e3106020001a	algf	%r1,32(%r6)
            >0000000076fc0312: e31010000082	xg	%r1,0(%r1)
             0000000076fc0318: b9040001		lgr	%r0,%r1
             0000000076fc031c: e30061700082	xg	%r0,368(%r6)
             0000000076fc0322: ec59000100d9	aghik	%r5,%r9,1
             0000000076fc0328: e34003b80004	lg	%r4,952
  Call Trace:
   [<0000000076fc0312>] __kmalloc+0xd2/0x398
   [<0000000076f318f2>] mempool_alloc+0x72/0x1f8
   [<000003ff8027c5f8>] zfcp_fsf_req_create.isra.7+0x40/0x268 [zfcp]
   [<000003ff8027f1bc>] zfcp_fsf_fcp_cmnd+0xac/0x3f0 [zfcp]
   [<000003ff80280f1a>] zfcp_scsi_queuecommand+0x122/0x1d0 [zfcp]
   [<000003ff800b4218>] scsi_queue_rq+0x778/0xa10 [scsi_mod]
   [<00000000771782a0>] __blk_mq_try_issue_directly+0x130/0x208
   [<000000007717a124>] blk_mq_request_issue_directly+0x4c/0xa8
   [<000003ff801302e2>] dm_mq_queue_rq+0x2ea/0x468 [dm_mod]
   [<0000000077178c12>] blk_mq_dispatch_rq_list+0x33a/0x818
   [<000000007717f064>] __blk_mq_do_dispatch_sched+0x284/0x2f0
   [<000000007717f44c>] __blk_mq_sched_dispatch_requests+0x1c4/0x218
   [<000000007717fa7a>] blk_mq_sched_dispatch_requests+0x52/0x90
   [<0000000077176d74>] __blk_mq_run_hw_queue+0x9c/0xc0
   [<0000000076da6d74>] process_one_work+0x274/0x4d0
   [<0000000076da7018>] worker_thread+0x48/0x560
   [<0000000076daef18>] kthread+0x140/0x160
   [<000000007751d144>] ret_from_fork+0x28/0x30
  Last Breaking-Event-Address:
   [<0000000076fc0474>] __kmalloc+0x234/0x398
  Kernel panic - not syncing: Fatal exception: panic_on_oops

To fix this, simply change the type of the cache variable to `unsigned
long`, like the rest of zfcp and also the argument for
`zfcp_reqlist_find_rm()`. This prevents truncation and wrong sign
extension and so can successfully remove the request from the hash
table.

Fixes: e60a6d69f1f8 ("[SCSI] zfcp: Remove function zfcp_reqlist_find_safe")
Cc: <stable@vger.kernel.org> #v2.6.34+
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 19223b075568..ab3ea529cca7 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -884,7 +884,7 @@ static int zfcp_fsf_req_send(struct zfcp_fsf_req *req)
 	const bool is_srb = zfcp_fsf_req_is_status_read_buffer(req);
 	struct zfcp_adapter *adapter = req->adapter;
 	struct zfcp_qdio *qdio = adapter->qdio;
-	int req_id = req->req_id;
+	unsigned long req_id = req->req_id;
 
 	zfcp_reqlist_add(adapter->req_list, req);
 

base-commit: ecb8c2580d37dbb641451049376d80c8afaa387f
-- 
2.38.1

