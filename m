Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5B00126236
	for <lists+linux-s390@lfdr.de>; Thu, 19 Dec 2019 13:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfLSMfF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Dec 2019 07:35:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35069 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMfE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Dec 2019 07:35:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so2500231plt.2
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+enTLPaxJhC1TwqAq4+1F2qGOQKD/UrJ0jEU9e+3gRs=;
        b=AVVsH4ZQJTG7PUhNZ+zAB3TrhrGWSyTSr61KlucnS3IksTaWlHRnzVi8pgdHgeg+1w
         /uZ5etKAgSYzCHehz5PhQssEh8n/UrzhuGik1x/ZuVb3rJazdXXxnzLUu69r0Cas+cQs
         SFjxhzqwfK1jrPKa048n7wh2Qt8gS2W+YAErnwBJbeh48orHTn38Pp5Igf5xcfVpYBmx
         MKeZ9rn+ApvIwaeJ7BZIqX+0mH75IyOY46wrL30GKbjeoZf5tHHlKeegGi/qeNNOT1fz
         5+kY4m7njdz2QPgniZcPK3h9DqZ8sbZjntfBVsu00swMx/ITnZKsO7+7Ebn30/vx0lDn
         ONew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+enTLPaxJhC1TwqAq4+1F2qGOQKD/UrJ0jEU9e+3gRs=;
        b=BuqnISaYu4t753LekNPExQs6tCqJo3AjwLlfQPUt+tCsdrBcjgtRSTDnH1i2fo4Y3n
         mvTtD3xQAeJCFRm4KgI9+RWbR94p07yw4MpoWdSqBLmPQFmEO3ADhMRNsSGACsWgsCk4
         uiFwQ/t0CeqrQyIVNQdD4sklXeFMluyiYAAZpbfTcF7JWUCZuiUo6Vw2bxAT+R9hNehq
         5soWZnAm0kVgJfH0trMPSk2d53Tpxec5+vTktuhqrGs6J8b4zWOHKlNSqkWw7qk2ERaB
         2AIlqnswMr5Xmlve6kyZiB4dnWZ/CWQpLGsYbgCkOU86PpR3lRzd7JBX42FdQxLogPJy
         2E8g==
X-Gm-Message-State: APjAAAX1mVdH0aIw4N/tb+uPp8c98guCL6qFPe9n/Ogx4AVJu4AWjqZn
        kZgIBM/ENZ5CjJUkgnGPWgb+ZA==
X-Google-Smtp-Source: APXvYqxwpK4qbhD/LMFfaxH+fRVezUHLOcOMQQEUJAWogK8KhDdXF0sZnsAkld/uIRu+uB7d3DLIEA==
X-Received: by 2002:a17:902:6802:: with SMTP id h2mr8746717plk.233.1576758902414;
        Thu, 19 Dec 2019 04:35:02 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z14sm8487146pfg.57.2019.12.19.04.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 04:35:01 -0800 (PST)
Subject: Re: [PATCH 0/3] s390/dasd patches
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20191219084352.75114-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <911ec978-791d-aac3-072b-dab9f3d1bf54@kernel.dk>
Date:   Thu, 19 Dec 2019 05:35:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219084352.75114-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/19/19 1:43 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please see the following three patches that
> 
>  - fix a dead code path for DASD
>  - fix a memleak in DASD error case
>  - fix typo in copyright statement

Applied for 5.5, thanks

-- 
Jens Axboe

