Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A12735AFA
	for <lists+linux-s390@lfdr.de>; Mon, 19 Jun 2023 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjFSPSb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 19 Jun 2023 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjFSPSb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Jun 2023 11:18:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9369B9;
        Mon, 19 Jun 2023 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=fnh6RCNEHzHmS6/XhMUtUgMq0ysRFuFiukVtZgZImCA=; b=yZwwXIIj5HgDds8uv5azf2KFL/
        2uOyxDsC2zQx94/fuYz/HMXyE8iaMYuq7Pq7xMj1XEJ5+hejE1RPa95u1uWWylGSY/5YnXx9JYyX3
        SGMuBbGF7xcCb388EMh5vL4UnxNMcKbq+xqjH3mH9qMrNY50KdylIB/2upUvNJzaRXSKhYF9BACD4
        8VNgCFIG8/QxP4ULg3KhAPOu2qEAY+ZryZrIWPBrpgN/g1jcybCU7SBpwX5oMvJG601MHpDM4ItjB
        QF5tdzW6P3J3PQhI44QvbuZFczBKdCYVuSyNXLAP38+ZAEWpKO1NBeue+wryY/JADpJ17hBvPTD+j
        rPNWaCaQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBGeB-008lL4-01;
        Mon, 19 Jun 2023 15:18:27 +0000
Message-ID: <7c7cc6b2-5c63-f893-d4ac-fcea40b2a4b4@infradead.org>
Date:   Mon, 19 Jun 2023 08:18:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] s390/net: lcs: use IS_ENABLED() for kconfig detection
Content-Language: en-US
To:     Alexandra Winter <wintera@linux.ibm.com>,
        patchwork-bot+netdevbpf@kernel.org
Cc:     linux-kernel@vger.kernel.org, wenjia@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
References: <20230615222152.13250-1-rdunlap@infradead.org>
 <168690302072.8823.785077843270614259.git-patchwork-notify@kernel.org>
 <4f2afa34-830a-3c17-99e7-1cb5b874e7ce@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4f2afa34-830a-3c17-99e7-1cb5b874e7ce@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 6/19/23 03:04, Alexandra Winter wrote:
> 
> 
> On 16.06.23 10:10, patchwork-bot+netdevbpf@kernel.org wrote:
>> Hello:
>>
>> This patch was applied to netdev/net-next.git (main)
>> by David S. Miller <davem@davemloft.net>:
>>
>> On Thu, 15 Jun 2023 15:21:52 -0700 you wrote:
>>> When CONFIG_ETHERNET=m or CONFIG_FDDI=m, lcs.s has build errors or
>>> warnings:
>>>
>  
> IIUC, CONFIG_ETHERNET is bool.

duh, yes. Thanks.

> I reproduced this with CONFIG_ETHERNET=n and CONFIG_FDDI=m,
> and verified that it does compile with your patch.
> 
> Thank you Randy for correcting this.
> 
>>> ../drivers/s390/net/lcs.c:40:2: error: #error Cannot compile lcs.c without some net devices switched on.
>>>    40 | #error Cannot compile lcs.c without some net devices switched on.
>>> ../drivers/s390/net/lcs.c: In function 'lcs_startlan_auto':
>>> ../drivers/s390/net/lcs.c:1601:13: warning: unused variable 'rc' [-Wunused-variable]
>>>  1601 |         int rc;
>>>
>>> [...]
>>
>> Here is the summary with links:
>>   - s390/net: lcs: use IS_ENABLED() for kconfig detection
>>     https://git.kernel.org/netdev/net-next/c/128272336120
>>
>> You are awesome, thank you!
> 

-- 
~Randy
