Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957DA286090
	for <lists+linux-s390@lfdr.de>; Wed,  7 Oct 2020 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgJGNy4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Oct 2020 09:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgJGNys (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 09:54:48 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0610DC0613D3
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 06:54:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t12so2360055ilh.3
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 06:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5xAx6y/5JiRXXWgVy0lo34k9ty9yQYwEFzj7BXHXi9E=;
        b=N0k+2Vf1KRg7F764OkadTiRVqCP/E0lZMZa38Y3lvF6gPfQ7CjVM2IaIn3uIOaOR0a
         Qob5yjt74dyUkm4tU3wuBCT7K0xn4nys6S8FJP9T6WmKnwb3XuFaFH06Qj9Nlu90ETcc
         HoGSNhuAQfZBKct7tqTNrm5OvyCdjnVWsM+EM530xWstuRRB7aATYOdVuqS6aIAoGTBw
         xytlhBpvHANXidMLH3BIKzvKuflPnATGE7TlfQf3751MXKWFkNpo9dJ85RSohIa1UYr5
         OxW/k8OUWr7GHdTCYg2w1HZz4KO5MQ69uBFTWiVPWZoGO5bUkzVhjdmNXK3QsgjYn8vd
         581A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xAx6y/5JiRXXWgVy0lo34k9ty9yQYwEFzj7BXHXi9E=;
        b=s7Omb2U2RfaBdDrHjbQBo8AAko/YvAeNCs1XxOA/d9Yn7hFF/d5vJiL01n6dukh4Db
         Vely5saEtjJob+xZnQhWJcYhisT52qId2bnL6bNlqhMZxuqVgaamyHi3Es65vcy8RAss
         2hA3DmdAY+O/fKbX4lubFO7g8gL+lcmfZAYVAfKE3oVjNhyZa82Pt9QyG3YMhLoOjMl5
         KOUoPWcOfOlpVTYkNqeA3HNF6uxAX6xurXVQcRjDKzRHXydsof9Xr5xk1kpEYawM1m+X
         qXj1DU93dQMfYlT4ez4DggaXIquNuWDRqgRZjtEcJpL+3kHbE4JuM70Oltfk2VosceWE
         fRlA==
X-Gm-Message-State: AOAM533g2B3PhYeLa7/+a3jqSkKARQxqDFL4dc9VdA67MxknWIw8gJoG
        nbfhAZoza6a/lpDh8Vb1LorvAA==
X-Google-Smtp-Source: ABdhPJwgrdZEMJp/c+cibVOjieUYh6JNQXgQNaNFuHR7uafgCzt5iLnmPkRzSHm5s+LsyJVaTjkwGQ==
X-Received: by 2002:a05:6e02:ea7:: with SMTP id u7mr2896251ilj.175.1602078886276;
        Wed, 07 Oct 2020 06:54:46 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t26sm890685ioi.11.2020.10.07.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 06:54:45 -0700 (PDT)
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, sth@linux.ibm.com,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201007124009.1438269-1-hch@lst.de>
 <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
 <20201007135411.GA1000@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <874c518d-7c15-d08a-61a2-116f605c4b5a@kernel.dk>
Date:   Wed, 7 Oct 2020 07:54:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007135411.GA1000@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/7/20 7:54 AM, Christoph Hellwig wrote:
> On Wed, Oct 07, 2020 at 07:53:27AM -0600, Jens Axboe wrote:
>> On 10/7/20 6:40 AM, Christoph Hellwig wrote:
>>> Don't error out if the dasd_biodasdinfo symbol is not available.
>>
>> Should this be marked for 5.8-stable?
> 
> The Fixes tag should automatically take care of that.

Not if it's not marked for stable. Maybe auto-selection will pick it
up, but it's not a given.


-- 
Jens Axboe

