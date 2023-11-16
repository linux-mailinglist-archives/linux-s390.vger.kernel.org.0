Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881BF7ED8D5
	for <lists+linux-s390@lfdr.de>; Thu, 16 Nov 2023 02:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjKPBPj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Nov 2023 20:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjKPBPi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Nov 2023 20:15:38 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF63197;
        Wed, 15 Nov 2023 17:15:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SW2CM4mQmz4f3jHc;
        Thu, 16 Nov 2023 09:15:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
        by mail.maildlp.com (Postfix) with ESMTP id 3829C1A0181;
        Thu, 16 Nov 2023 09:15:30 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP4 (Coremail) with SMTP id gCh0CgAnNUUubVVlby1OBA--.26664S2;
        Thu, 16 Nov 2023 09:15:30 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 01/13] bpf: Add support for non-fix-size
 percpu mem allocation
To:     Heiko Carstens <hca@linux.ibm.com>,
        Yonghong Song <yonghong.song@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        linux-s390@vger.kernel.org
References: <20230827152729.1995219-1-yonghong.song@linux.dev>
 <20230827152734.1995725-1-yonghong.song@linux.dev>
 <20231115153139.29313-A-hca@linux.ibm.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <379ff74e-cad2-919c-4130-adbe80d50a26@huaweicloud.com>
Date:   Thu, 16 Nov 2023 09:15:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20231115153139.29313-A-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: gCh0CgAnNUUubVVlby1OBA--.26664S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw15tr47KFyDtr18Jry3CFg_yoW8WrW3pF
        4fGFyxWrn3Arn3Ca17uw48WF1Fy395K3W7tw4jyw1DCry3Xryqkws8Xrs3ur98ArZY9FW5
        XrZ0vF9xZFy8Z37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

On 11/15/2023 11:31 PM, Heiko Carstens wrote:
> On Sun, Aug 27, 2023 at 08:27:34AM -0700, Yonghong Song wrote:
>> This is needed for later percpu mem allocation when the
>> allocation is done by bpf program. For such cases, a global
>> bpf_global_percpu_ma is added where a flexible allocation
>> size is needed.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>  include/linux/bpf.h   |  4 ++--
>>  kernel/bpf/core.c     |  8 +++++---
>>  kernel/bpf/memalloc.c | 14 ++++++--------
>>  3 files changed, 13 insertions(+), 13 deletions(-)
> Both Marc and Mikhail reported out-of-memory conditions on s390 machines,
> and bisected it down to this upstream commit 41a5db8d8161 ("bpf: Add
> support for non-fix-size percpu mem allocation").
> This seems to eat up a lot of memory only based on the number of possible
> CPUs.
>
> If we have a machine with 8GB, 6 present CPUs and 512 possible CPUs (yes,
> this is a realistic scenario) the memory consumption directly after boot
> is:
>
> $ cat /sys/devices/system/cpu/present
> 0-5
> $ cat /sys/devices/system/cpu/possible
> 0-511

Will the present CPUs be hot-added dynamically and eventually increase
to 512 CPUs ? Or will the present CPUs rarely be hot-added ? After all
possible CPUs are online, will these CPUs be hot-plugged dynamically ?
Because I am considering add CPU hotplug support for bpf mem allocator,
so we can allocate memory according to the present CPUs instead of
possible CPUs. But if the present CPUs will be increased to all possible
CPUs quickly, there will be not too much benefit to support hotplug in
bpf mem allocator.

