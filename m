Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74341183143
	for <lists+linux-s390@lfdr.de>; Thu, 12 Mar 2020 14:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgCLNZK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Mar 2020 09:25:10 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43354 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLNZK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Mar 2020 09:25:10 -0400
Received: by mail-il1-f194.google.com with SMTP id d14so4898129ilq.10
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ndnidSMgbYt+qzNKk/4/2bWrrY0w3HilPAmXJWDTL4Q=;
        b=j2fLK1yQ1ortgRcw1ToWl7Hgm1ON4eyInI1+OmtrgO45378Qr26uVfDVijiLCIANfe
         3m75de7r1G7OH1qDVA14pkMvjl4mrZXxCvjG7CBt8iq/PVpNUQSFHQTcM+cBbZC6t9fF
         XgPerNx+CEciaR6t/q/FHYxdqf/VQYgDYmOtcrnvVsHv5PXjVJr6+ELT2LxI15QiJXzp
         QgcEjU6zaKR6CpLxrVB6jXVV43ZzuVskpjdOB4THEnoDAdC4GQb5baSYVhByFlAMAAI6
         XpJP8oxV1khVe4gPOpmf6GL9TSOTgBWipleYxau/FURYUMWyiHTQVJj1f8Pk28evbWNQ
         h/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ndnidSMgbYt+qzNKk/4/2bWrrY0w3HilPAmXJWDTL4Q=;
        b=s90eit0mEe1s71kcBe5wu6WubxR44/5Y3rz/IpEt26tsxHDvy0JXOoT3hIeh6Wu9yY
         O3zFIgyRudN5wGUebXbgBWRTpk8E+u5u+NECxvPGsnWegPjOUyUk9ciNvJc+HNIotyuT
         /0V3QpAFV3ycAfaD2llevytJ8mxtFMoEzy/gWGEzr0XQ38wqLhTjrL/E5GO8/bB+ZZzi
         aMYvgLVvEkvqZC+0uXbLm+tknlOnKbJ2V8NUNGDYsUEGUaAuDNShwAL7mCMrtUsFUBLi
         Umt+MoresM3M+MVjUewqaOqZxgauh7ze4q6tWPofYHmbnhhALXfvy3SnsZl3jsEpOK84
         yUmw==
X-Gm-Message-State: ANhLgQ2LfTZTMLjxpzbheDAASgfYR0YUwshdp1eieTOG2y8fjJKx87ET
        Ztlo8Kph6Hy+A+zc+k9oUQ8jpA==
X-Google-Smtp-Source: ADFU+vt5nQOomXXOScFsa6s0vY6t1+4y/eXJEjAl2SpQxRch9HKvoVi3xB9ozUDslttbY15KnzmlQw==
X-Received: by 2002:a92:9642:: with SMTP id g63mr8726810ilh.223.1584019509797;
        Thu, 12 Mar 2020 06:25:09 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 27sm4909513ilv.75.2020.03.12.06.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:25:09 -0700 (PDT)
Subject: Re: [PATCH 0/1] s390/dasd: fix data corruption
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200312131715.72621-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cd6a5017-7db4-3d66-c58d-40d8b0fda61c@kernel.dk>
Date:   Thu, 12 Mar 2020 07:25:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312131715.72621-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 3/12/20 7:17 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please find following patch that fixes a likely data corruption when using
> devices with thin provisioning support.
> As this is a severe issue I hope this will make it into RC6. If not, please
> let me know.

Applied for 5.6, thanks.

-- 
Jens Axboe

